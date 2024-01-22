import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grpc/grpc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rom/models/estimated_pose.dart';
import 'package:rom/service/channel.dart';
import 'package:rom/service/errors.dart';
import 'package:rom/service/protocols/ping.pb.dart';
import 'package:rom/service/protocols/pose.pbgrpc.dart';
import 'package:rom/service/protocols/pose_analyse_video.pb.dart';

class PoseService extends GetxService {
  late PoseClient _api;

  final mem = GetStorage();

  final _jointsFromMap = <String, Joint>{
    "LEFT_SHOULDER": Joint.LEFT_SHOULDER,
    "RIGHT_SHOULDER": Joint.RIGHT_SHOULDER,
    "LEFT_ELBOW": Joint.LEFT_ELBOW,
    "RIGHT_ELBOW": Joint.RIGHT_ELBOW,
    "LEFT_HIP": Joint.LEFT_HIP,
    "RIGHT_HIP": Joint.RIGHT_HIP,
    "LEFT_KNEE": Joint.LEFT_KNEE,
    "RIGHT_KNEE": Joint.RIGHT_KNEE,
  };

  @override
  void onInit() {
    super.onInit();
    connect('localhost');
  }

  PoseClient _initGrpcApi({required String host, int port = 50052}) =>
      PoseClient(createGrpcChannel(host, port));

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

  Future<Result<EstimatedPose, ServiceError>> analyseVideo({
    required String user,
    required String name,
    required XFile video,
    required double frameStep,
    required Map<String, bool> joints,
    bool useCached = true,
  }) async {
    try {
      final res = await _api.analyseVideo(
        AnalyseVideoReq(
          name: name,
          frameStep: frameStep.toInt(),
          joints: joints.entries
              .where((e) => e.value)
              .map((e) => _jointsFromMap[e.key]!)
              .toList(),
          useCached: useCached,
          video: await video.readAsBytes(),
        ),
        options: CallOptions(
          timeout: const Duration(minutes: 5),
          metadata: {'access-token': mem.read('access-token')},
        ),
      );
      final directory = await getApplicationDocumentsDirectory();

      await Directory('${directory.path}/$user/videos').create(recursive: true);
      video.saveTo('${directory.path}/$user/videos/$name');

      List<Image> analysedFrames = [];
      List<Uint8List> analysedFrameBytes = [];
      await Future.forEach(res.analysedFrames.asMap().entries, (e) async {
        final index = e.key;
        final image = e.value;
        await Directory('${directory.path}/$user/analysed-frames/$name')
            .create(recursive: true);
        final File file =
            File('${directory.path}/$user/analysed-frames/$name/$index');
        await file.writeAsBytes(image);
        analysedFrames.add(Image.memory(Uint8List.fromList(image)));
        analysedFrameBytes.add(Uint8List.fromList(image));
      });

      final angles = Map.fromEntries(
          res.angles.map((e) => MapEntry(e.joint.toString(), e.angles)));

      return Result.success(EstimatedPose(
        images: analysedFrames,
        imageBytes: analysedFrameBytes,
        angles: angles,
      ));
    } on GrpcError catch (e) {
      if (e.code == StatusCode.unavailable) {
        Get.printError(info: 'error ${e.code} ${e.message}');
        return Result.error(ServiceError.unavailable());
      } else {
        return Result.error(ServiceError(code: e.code, message: e.message));
      }
    } catch (e) {
      return Result.error(
          ServiceError(code: StatusCode.unknown, message: e.toString()));
    }
  }
}
