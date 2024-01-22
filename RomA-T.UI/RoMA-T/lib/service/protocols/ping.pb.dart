///
//  Generated code. Do not modify.
//  source: ping.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class PingReq extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PingReq', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'protocol'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  PingReq._() : super();
  factory PingReq() => create();
  factory PingReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PingReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PingReq clone() => PingReq()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PingReq copyWith(void Function(PingReq) updates) => super.copyWith((message) => updates(message as PingReq)) as PingReq; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PingReq create() => PingReq._();
  PingReq createEmptyInstance() => create();
  static $pb.PbList<PingReq> createRepeated() => $pb.PbList<PingReq>();
  @$core.pragma('dart2js:noInline')
  static PingReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PingReq>(create);
  static PingReq? _defaultInstance;
}

class PingRes extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PingRes', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'protocol'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  PingRes._() : super();
  factory PingRes() => create();
  factory PingRes.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PingRes.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PingRes clone() => PingRes()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PingRes copyWith(void Function(PingRes) updates) => super.copyWith((message) => updates(message as PingRes)) as PingRes; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PingRes create() => PingRes._();
  PingRes createEmptyInstance() => create();
  static $pb.PbList<PingRes> createRepeated() => $pb.PbList<PingRes>();
  @$core.pragma('dart2js:noInline')
  static PingRes getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PingRes>(create);
  static PingRes? _defaultInstance;
}

