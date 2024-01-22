import 'package:grpc/grpc.dart';

class ServiceError {
  final int code;
  final String? message;

  ServiceError({required this.code, this.message});

  factory ServiceError.unavailable() {
    return ServiceError(
      code: StatusCode.unavailable,
      message: 'service unavailable',
    );
  }
}
