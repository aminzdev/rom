///
//  Generated code. Do not modify.
//  source: auth_sign_in.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use signInReqDescriptor instead')
const SignInReq$json = const {
  '1': 'SignInReq',
  '2': const [
    const {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.protocol.User', '10': 'user'},
  ],
};

/// Descriptor for `SignInReq`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signInReqDescriptor = $convert.base64Decode('CglTaWduSW5SZXESIgoEdXNlchgBIAEoCzIOLnByb3RvY29sLlVzZXJSBHVzZXI=');
@$core.Deprecated('Use signInResDescriptor instead')
const SignInRes$json = const {
  '1': 'SignInRes',
  '2': const [
    const {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
  ],
};

/// Descriptor for `SignInRes`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signInResDescriptor = $convert.base64Decode('CglTaWduSW5SZXMSFAoFdG9rZW4YASABKAlSBXRva2Vu');
