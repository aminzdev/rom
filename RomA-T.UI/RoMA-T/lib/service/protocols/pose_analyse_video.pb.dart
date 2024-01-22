///
//  Generated code. Do not modify.
//  source: pose_analyse_video.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'pose_analyse_video.pbenum.dart';

export 'pose_analyse_video.pbenum.dart';

class AnalyseVideoReq extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AnalyseVideoReq', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'protocol'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'frameStep', $pb.PbFieldType.OU3)
    ..pc<Joint>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'joints', $pb.PbFieldType.KE, valueOf: Joint.valueOf, enumValues: Joint.values, defaultEnumValue: Joint.LEFT_SHOULDER)
    ..aOB(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'useCached')
    ..a<$core.List<$core.int>>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'video', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  AnalyseVideoReq._() : super();
  factory AnalyseVideoReq({
    $core.String? name,
    $core.int? frameStep,
    $core.Iterable<Joint>? joints,
    $core.bool? useCached,
    $core.List<$core.int>? video,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (frameStep != null) {
      _result.frameStep = frameStep;
    }
    if (joints != null) {
      _result.joints.addAll(joints);
    }
    if (useCached != null) {
      _result.useCached = useCached;
    }
    if (video != null) {
      _result.video = video;
    }
    return _result;
  }
  factory AnalyseVideoReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AnalyseVideoReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AnalyseVideoReq clone() => AnalyseVideoReq()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AnalyseVideoReq copyWith(void Function(AnalyseVideoReq) updates) => super.copyWith((message) => updates(message as AnalyseVideoReq)) as AnalyseVideoReq; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AnalyseVideoReq create() => AnalyseVideoReq._();
  AnalyseVideoReq createEmptyInstance() => create();
  static $pb.PbList<AnalyseVideoReq> createRepeated() => $pb.PbList<AnalyseVideoReq>();
  @$core.pragma('dart2js:noInline')
  static AnalyseVideoReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AnalyseVideoReq>(create);
  static AnalyseVideoReq? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get frameStep => $_getIZ(1);
  @$pb.TagNumber(2)
  set frameStep($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFrameStep() => $_has(1);
  @$pb.TagNumber(2)
  void clearFrameStep() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<Joint> get joints => $_getList(2);

  @$pb.TagNumber(4)
  $core.bool get useCached => $_getBF(3);
  @$pb.TagNumber(4)
  set useCached($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasUseCached() => $_has(3);
  @$pb.TagNumber(4)
  void clearUseCached() => clearField(4);

  @$pb.TagNumber(5)
  $core.List<$core.int> get video => $_getN(4);
  @$pb.TagNumber(5)
  set video($core.List<$core.int> v) { $_setBytes(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasVideo() => $_has(4);
  @$pb.TagNumber(5)
  void clearVideo() => clearField(5);
}

class AnalyseVideoRes extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AnalyseVideoRes', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'protocol'), createEmptyInstance: create)
    ..p<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'analysedFrames', $pb.PbFieldType.PY)
    ..pc<EstimatedAngles>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'angles', $pb.PbFieldType.PM, subBuilder: EstimatedAngles.create)
    ..hasRequiredFields = false
  ;

  AnalyseVideoRes._() : super();
  factory AnalyseVideoRes({
    $core.Iterable<$core.List<$core.int>>? analysedFrames,
    $core.Iterable<EstimatedAngles>? angles,
  }) {
    final _result = create();
    if (analysedFrames != null) {
      _result.analysedFrames.addAll(analysedFrames);
    }
    if (angles != null) {
      _result.angles.addAll(angles);
    }
    return _result;
  }
  factory AnalyseVideoRes.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AnalyseVideoRes.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AnalyseVideoRes clone() => AnalyseVideoRes()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AnalyseVideoRes copyWith(void Function(AnalyseVideoRes) updates) => super.copyWith((message) => updates(message as AnalyseVideoRes)) as AnalyseVideoRes; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AnalyseVideoRes create() => AnalyseVideoRes._();
  AnalyseVideoRes createEmptyInstance() => create();
  static $pb.PbList<AnalyseVideoRes> createRepeated() => $pb.PbList<AnalyseVideoRes>();
  @$core.pragma('dart2js:noInline')
  static AnalyseVideoRes getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AnalyseVideoRes>(create);
  static AnalyseVideoRes? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.List<$core.int>> get analysedFrames => $_getList(0);

  @$pb.TagNumber(2)
  $core.List<EstimatedAngles> get angles => $_getList(1);
}

class EstimatedAngles extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'EstimatedAngles', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'protocol'), createEmptyInstance: create)
    ..e<Joint>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'joint', $pb.PbFieldType.OE, defaultOrMaker: Joint.LEFT_SHOULDER, valueOf: Joint.valueOf, enumValues: Joint.values)
    ..p<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'angles', $pb.PbFieldType.KF)
    ..hasRequiredFields = false
  ;

  EstimatedAngles._() : super();
  factory EstimatedAngles({
    Joint? joint,
    $core.Iterable<$core.double>? angles,
  }) {
    final _result = create();
    if (joint != null) {
      _result.joint = joint;
    }
    if (angles != null) {
      _result.angles.addAll(angles);
    }
    return _result;
  }
  factory EstimatedAngles.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EstimatedAngles.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EstimatedAngles clone() => EstimatedAngles()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EstimatedAngles copyWith(void Function(EstimatedAngles) updates) => super.copyWith((message) => updates(message as EstimatedAngles)) as EstimatedAngles; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static EstimatedAngles create() => EstimatedAngles._();
  EstimatedAngles createEmptyInstance() => create();
  static $pb.PbList<EstimatedAngles> createRepeated() => $pb.PbList<EstimatedAngles>();
  @$core.pragma('dart2js:noInline')
  static EstimatedAngles getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EstimatedAngles>(create);
  static EstimatedAngles? _defaultInstance;

  @$pb.TagNumber(1)
  Joint get joint => $_getN(0);
  @$pb.TagNumber(1)
  set joint(Joint v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasJoint() => $_has(0);
  @$pb.TagNumber(1)
  void clearJoint() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.double> get angles => $_getList(1);
}

