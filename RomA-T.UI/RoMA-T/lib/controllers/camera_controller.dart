import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rom/models/video_model.dart';

class CameraController extends GetxController {
  Future<Result<Video, String>> pickVideo({required ImageSource source}) async {
    try {
      final file = await ImagePicker().pickVideo(source: source);
      return file != null
          ? Result.success(Video(name: file.name, file: file))
          : Result.error('video selection was canceled');
    } on PlatformException {
      return Result.error(
          'permission not granted to access the camera or photos gallery');
    }
  }
}
