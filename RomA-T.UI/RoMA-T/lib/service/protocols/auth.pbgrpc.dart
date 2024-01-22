///
//  Generated code. Do not modify.
//  source: auth.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'ping.pb.dart' as $0;
import 'auth_sign_in.pb.dart' as $1;
import 'auth_sign_up.pb.dart' as $2;
import 'auth_sign_out.pb.dart' as $3;
export 'auth.pb.dart';

class AuthClient extends $grpc.Client {
  static final _$ping = $grpc.ClientMethod<$0.PingReq, $0.PingRes>(
      '/protocol.Auth/Ping',
      ($0.PingReq value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.PingRes.fromBuffer(value));
  static final _$signIn = $grpc.ClientMethod<$1.SignInReq, $1.SignInRes>(
      '/protocol.Auth/SignIn',
      ($1.SignInReq value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.SignInRes.fromBuffer(value));
  static final _$signUp = $grpc.ClientMethod<$2.SignUpReq, $2.SignUpRes>(
      '/protocol.Auth/SignUp',
      ($2.SignUpReq value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.SignUpRes.fromBuffer(value));
  static final _$signOut = $grpc.ClientMethod<$3.SignOutReq, $3.SignOutRes>(
      '/protocol.Auth/SignOut',
      ($3.SignOutReq value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $3.SignOutRes.fromBuffer(value));

  AuthClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.PingRes> ping($0.PingReq request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$ping, request, options: options);
  }

  $grpc.ResponseFuture<$1.SignInRes> signIn($1.SignInReq request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$signIn, request, options: options);
  }

  $grpc.ResponseFuture<$2.SignUpRes> signUp($2.SignUpReq request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$signUp, request, options: options);
  }

  $grpc.ResponseFuture<$3.SignOutRes> signOut($3.SignOutReq request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$signOut, request, options: options);
  }
}

abstract class AuthServiceBase extends $grpc.Service {
  $core.String get $name => 'protocol.Auth';

  AuthServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.PingReq, $0.PingRes>(
        'Ping',
        ping_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.PingReq.fromBuffer(value),
        ($0.PingRes value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.SignInReq, $1.SignInRes>(
        'SignIn',
        signIn_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.SignInReq.fromBuffer(value),
        ($1.SignInRes value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.SignUpReq, $2.SignUpRes>(
        'SignUp',
        signUp_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.SignUpReq.fromBuffer(value),
        ($2.SignUpRes value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.SignOutReq, $3.SignOutRes>(
        'SignOut',
        signOut_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $3.SignOutReq.fromBuffer(value),
        ($3.SignOutRes value) => value.writeToBuffer()));
  }

  $async.Future<$0.PingRes> ping_Pre(
      $grpc.ServiceCall call, $async.Future<$0.PingReq> request) async {
    return ping(call, await request);
  }

  $async.Future<$1.SignInRes> signIn_Pre(
      $grpc.ServiceCall call, $async.Future<$1.SignInReq> request) async {
    return signIn(call, await request);
  }

  $async.Future<$2.SignUpRes> signUp_Pre(
      $grpc.ServiceCall call, $async.Future<$2.SignUpReq> request) async {
    return signUp(call, await request);
  }

  $async.Future<$3.SignOutRes> signOut_Pre(
      $grpc.ServiceCall call, $async.Future<$3.SignOutReq> request) async {
    return signOut(call, await request);
  }

  $async.Future<$0.PingRes> ping($grpc.ServiceCall call, $0.PingReq request);
  $async.Future<$1.SignInRes> signIn(
      $grpc.ServiceCall call, $1.SignInReq request);
  $async.Future<$2.SignUpRes> signUp(
      $grpc.ServiceCall call, $2.SignUpReq request);
  $async.Future<$3.SignOutRes> signOut(
      $grpc.ServiceCall call, $3.SignOutReq request);
}
