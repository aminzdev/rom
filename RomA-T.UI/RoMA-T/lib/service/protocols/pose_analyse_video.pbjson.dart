///
//  Generated code. Do not modify.
//  source: pose_analyse_video.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use jointDescriptor instead')
const Joint$json = const {
  '1': 'Joint',
  '2': const [
    const {'1': 'LEFT_SHOULDER', '2': 0},
    const {'1': 'RIGHT_SHOULDER', '2': 1},
    const {'1': 'LEFT_ELBOW', '2': 2},
    const {'1': 'RIGHT_ELBOW', '2': 3},
    const {'1': 'LEFT_HIP', '2': 4},
    const {'1': 'RIGHT_HIP', '2': 5},
    const {'1': 'LEFT_KNEE', '2': 6},
    const {'1': 'RIGHT_KNEE', '2': 7},
  ],
};

/// Descriptor for `Joint`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List jointDescriptor = $convert.base64Decode('CgVKb2ludBIRCg1MRUZUX1NIT1VMREVSEAASEgoOUklHSFRfU0hPVUxERVIQARIOCgpMRUZUX0VMQk9XEAISDwoLUklHSFRfRUxCT1cQAxIMCghMRUZUX0hJUBAEEg0KCVJJR0hUX0hJUBAFEg0KCUxFRlRfS05FRRAGEg4KClJJR0hUX0tORUUQBw==');
@$core.Deprecated('Use analyseVideoReqDescriptor instead')
const AnalyseVideoReq$json = const {
  '1': 'AnalyseVideoReq',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'frame_step', '3': 2, '4': 1, '5': 13, '10': 'frameStep'},
    const {'1': 'joints', '3': 3, '4': 3, '5': 14, '6': '.protocol.Joint', '10': 'joints'},
    const {'1': 'use_cached', '3': 4, '4': 1, '5': 8, '10': 'useCached'},
    const {'1': 'video', '3': 5, '4': 1, '5': 12, '10': 'video'},
  ],
};

/// Descriptor for `AnalyseVideoReq`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List analyseVideoReqDescriptor = $convert.base64Decode('Cg9BbmFseXNlVmlkZW9SZXESEgoEbmFtZRgBIAEoCVIEbmFtZRIdCgpmcmFtZV9zdGVwGAIgASgNUglmcmFtZVN0ZXASJwoGam9pbnRzGAMgAygOMg8ucHJvdG9jb2wuSm9pbnRSBmpvaW50cxIdCgp1c2VfY2FjaGVkGAQgASgIUgl1c2VDYWNoZWQSFAoFdmlkZW8YBSABKAxSBXZpZGVv');
@$core.Deprecated('Use analyseVideoResDescriptor instead')
const AnalyseVideoRes$json = const {
  '1': 'AnalyseVideoRes',
  '2': const [
    const {'1': 'analysed_frames', '3': 1, '4': 3, '5': 12, '10': 'analysedFrames'},
    const {'1': 'angles', '3': 2, '4': 3, '5': 11, '6': '.protocol.EstimatedAngles', '10': 'angles'},
  ],
};

/// Descriptor for `AnalyseVideoRes`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List analyseVideoResDescriptor = $convert.base64Decode('Cg9BbmFseXNlVmlkZW9SZXMSJwoPYW5hbHlzZWRfZnJhbWVzGAEgAygMUg5hbmFseXNlZEZyYW1lcxIxCgZhbmdsZXMYAiADKAsyGS5wcm90b2NvbC5Fc3RpbWF0ZWRBbmdsZXNSBmFuZ2xlcw==');
@$core.Deprecated('Use estimatedAnglesDescriptor instead')
const EstimatedAngles$json = const {
  '1': 'EstimatedAngles',
  '2': const [
    const {'1': 'joint', '3': 1, '4': 1, '5': 14, '6': '.protocol.Joint', '10': 'joint'},
    const {'1': 'angles', '3': 2, '4': 3, '5': 2, '10': 'angles'},
  ],
};

/// Descriptor for `EstimatedAngles`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List estimatedAnglesDescriptor = $convert.base64Decode('Cg9Fc3RpbWF0ZWRBbmdsZXMSJQoFam9pbnQYASABKA4yDy5wcm90b2NvbC5Kb2ludFIFam9pbnQSFgoGYW5nbGVzGAIgAygCUgZhbmdsZXM=');
