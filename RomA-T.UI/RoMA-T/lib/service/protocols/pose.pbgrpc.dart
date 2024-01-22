///
//  Generated code. Do not modify.
//  source: pose.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'ping.pb.dart' as $0;
import 'pose_analyse_video.pb.dart' as $4;
export 'pose.pb.dart';

class PoseClient extends $grpc.Client {
  static final _$ping = $grpc.ClientMethod<$0.PingReq, $0.PingRes>(
      '/protocol.Pose/Ping',
      ($0.PingReq value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.PingRes.fromBuffer(value));
  static final _$analyseVideo =
      $grpc.ClientMethod<$4.AnalyseVideoReq, $4.AnalyseVideoRes>(
          '/protocol.Pose/AnalyseVideo',
          ($4.AnalyseVideoReq value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $4.AnalyseVideoRes.fromBuffer(value));

  PoseClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.PingRes> ping($0.PingReq request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$ping, request, options: options);
  }

  $grpc.ResponseFuture<$4.AnalyseVideoRes> analyseVideo(
      $4.AnalyseVideoReq request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$analyseVideo, request, options: options);
  }
}

abstract class PoseServiceBase extends $grpc.Service {
  $core.String get $name => 'protocol.Pose';

  PoseServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.PingReq, $0.PingRes>(
        'Ping',
        ping_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.PingReq.fromBuffer(value),
        ($0.PingRes value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.AnalyseVideoReq, $4.AnalyseVideoRes>(
        'AnalyseVideo',
        analyseVideo_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $4.AnalyseVideoReq.fromBuffer(value),
        ($4.AnalyseVideoRes value) => value.writeToBuffer()));
  }

  $async.Future<$0.PingRes> ping_Pre(
      $grpc.ServiceCall call, $async.Future<$0.PingReq> request) async {
    return ping(call, await request);
  }

  $async.Future<$4.AnalyseVideoRes> analyseVideo_Pre(
      $grpc.ServiceCall call, $async.Future<$4.AnalyseVideoReq> request) async {
    return analyseVideo(call, await request);
  }

  $async.Future<$0.PingRes> ping($grpc.ServiceCall call, $0.PingReq request);
  $async.Future<$4.AnalyseVideoRes> analyseVideo(
      $grpc.ServiceCall call, $4.AnalyseVideoReq request);
}
