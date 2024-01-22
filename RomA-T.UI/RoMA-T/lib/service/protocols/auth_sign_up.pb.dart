///
//  Generated code. Do not modify.
//  source: auth_sign_up.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'user.pb.dart' as $5;

class SignUpReq extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SignUpReq', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'protocol'), createEmptyInstance: create)
    ..aOM<$5.User>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'user', subBuilder: $5.User.create)
    ..hasRequiredFields = false
  ;

  SignUpReq._() : super();
  factory SignUpReq({
    $5.User? user,
  }) {
    final _result = create();
    if (user != null) {
      _result.user = user;
    }
    return _result;
  }
  factory SignUpReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SignUpReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SignUpReq clone() => SignUpReq()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SignUpReq copyWith(void Function(SignUpReq) updates) => super.copyWith((message) => updates(message as SignUpReq)) as SignUpReq; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SignUpReq create() => SignUpReq._();
  SignUpReq createEmptyInstance() => create();
  static $pb.PbList<SignUpReq> createRepeated() => $pb.PbList<SignUpReq>();
  @$core.pragma('dart2js:noInline')
  static SignUpReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SignUpReq>(create);
  static SignUpReq? _defaultInstance;

  @$pb.TagNumber(1)
  $5.User get user => $_getN(0);
  @$pb.TagNumber(1)
  set user($5.User v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasUser() => $_has(0);
  @$pb.TagNumber(1)
  void clearUser() => clearField(1);
  @$pb.TagNumber(1)
  $5.User ensureUser() => $_ensure(0);
}

class SignUpRes extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SignUpRes', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'protocol'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  SignUpRes._() : super();
  factory SignUpRes() => create();
  factory SignUpRes.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SignUpRes.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SignUpRes clone() => SignUpRes()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SignUpRes copyWith(void Function(SignUpRes) updates) => super.copyWith((message) => updates(message as SignUpRes)) as SignUpRes; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SignUpRes create() => SignUpRes._();
  SignUpRes createEmptyInstance() => create();
  static $pb.PbList<SignUpRes> createRepeated() => $pb.PbList<SignUpRes>();
  @$core.pragma('dart2js:noInline')
  static SignUpRes getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SignUpRes>(create);
  static SignUpRes? _defaultInstance;
}

