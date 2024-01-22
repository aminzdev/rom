///
//  Generated code. Do not modify.
//  source: pose_analyse_video.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class Joint extends $pb.ProtobufEnum {
  static const Joint LEFT_SHOULDER = Joint._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'LEFT_SHOULDER');
  static const Joint RIGHT_SHOULDER = Joint._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RIGHT_SHOULDER');
  static const Joint LEFT_ELBOW = Joint._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'LEFT_ELBOW');
  static const Joint RIGHT_ELBOW = Joint._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RIGHT_ELBOW');
  static const Joint LEFT_HIP = Joint._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'LEFT_HIP');
  static const Joint RIGHT_HIP = Joint._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RIGHT_HIP');
  static const Joint LEFT_KNEE = Joint._(6, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'LEFT_KNEE');
  static const Joint RIGHT_KNEE = Joint._(7, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RIGHT_KNEE');

  static const $core.List<Joint> values = <Joint> [
    LEFT_SHOULDER,
    RIGHT_SHOULDER,
    LEFT_ELBOW,
    RIGHT_ELBOW,
    LEFT_HIP,
    RIGHT_HIP,
    LEFT_KNEE,
    RIGHT_KNEE,
  ];

  static final $core.Map<$core.int, Joint> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Joint? valueOf($core.int value) => _byValue[value];

  const Joint._($core.int v, $core.String n) : super(v, n);
}

