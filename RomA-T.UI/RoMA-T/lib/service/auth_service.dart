import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grpc/grpc.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rom/service/channel.dart';
import 'package:rom/service/errors.dart';
import 'package:rom/service/protocols/auth.pbgrpc.dart';
import 'package:rom/service/protocols/ping.pb.dart';
import 'package:rom/service/protocols/auth_sign_in.pb.dart';
import 'package:rom/service/protocols/auth_sign_out.pb.dart';
import 'package:rom/service/protocols/auth_sign_up.pb.dart';
import 'package:rom/service/protocols/user.pb.dart';

class AuthService extends GetxService {
  late AuthClient _api;

  final mem = GetStorage();

  @override
  void onInit() {
    super.onInit();
    connect('localhost');
  }

  AuthClient _initGrpcApi({required String host, int port = 50051}) =>
      AuthClient(createGrpcChannel(host, port));

  void connect(String address) {
    _api = _initGrpcApi(host: address);
  }

  Future<Result<String, ServiceError>> ping(String address) async {
    try {
      connect(address);
      await _api.ping(PingReq());
      return Result.success("");
    } on GrpcError catch (e) {
      if (e.code == StatusCode.unavailable) {
        Get.printError(info: 'error ${e.code} ${e.message}');
        return Result.error(ServiceError.unavailable());
      } else {
        return Result.error(ServiceError(code: e.code, message: e.message));
      }
    } catch (e) {
      return Result.error(
        ServiceError(code: StatusCode.unknown, message: e.toString()),
      );
    }
  }

  Future<Result<String, ServiceError>> signin(
      {required String name, required String code}) async {
    try {
      final res = await _api.signIn(
        SignInReq(user: User(name: name, code: code)),
        options: CallOptions(timeout: const Duration(minutes: 5)),
      );

      mem.write('user', name);
      mem.write('code', code);
      mem.write('access-token', res.token);

      return Result.success("");
    } on GrpcError catch (e) {
      if (e.code == StatusCode.unavailable) {
        Get.printError(info: 'error ${e.code} ${e.message}');
        return Result.error(ServiceError.unavailable());
      } else {
        return Result.error(ServiceError(code: e.code, message: e.message));
      }
    } catch (e) {
      return Result.error(
        ServiceError(code: StatusCode.unknown, message: e.toString()),
      );
    }
  }

  Future<Result<String, ServiceError>> signup(
      {required String name, required String code}) async {
    try {
      final _ = await _api.signUp(
        SignUpReq(user: User(name: name, code: code)),
        options: CallOptions(timeout: const Duration(minutes: 5)),
      );

      return Result.success("");
    } on GrpcError catch (e) {
      if (e.code == StatusCode.unavailable) {
        Get.printError(info: 'error ${e.code} ${e.message}');
        return Result.error(ServiceError.unavailable());
      } else {
        return Result.error(ServiceError(code: e.code, message: e.message));
      }
    } catch (e) {
      return Result.error(
        ServiceError(code: StatusCode.unknown, message: e.toString()),
      );
    }
  }

  Future<Result<String, ServiceError>> signout() async {
    final user = mem.read('user') as String?;
    if (user == null || user.isEmpty) {
      return Result.success("");
    }
    try {
      final _ = await _api.signOut(
        SignOutReq(user: user),
        options: CallOptions(timeout: const Duration(minutes: 5), metadata: {'access-token': mem.read('access-token')}),
      );

      mem.remove('user');
      mem.remove('code');
      mem.remove('access-token');

      return Result.success("");
    } on GrpcError catch (e) {
      if (e.code == StatusCode.unavailable) {
        Get.printError(info: 'error ${e.code} ${e.message}');
        return Result.error(ServiceError.unavailable());
      } else {
        return Result.error(ServiceError(code: e.code, message: e.message));
      }
    } catch (e) {
      return Result.error(
        ServiceError(code: StatusCode.unknown, message: e.toString()),
      );
    }
  }
}
