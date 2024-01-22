import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rom/controllers/app_controller.dart';
import 'package:rom/models/video_model.dart';

class VideoListController extends GetxController
    with StateMixin<Map<String, Video>> {
  final videos = <String, Video>{};

  @override
  void onInit() {
    super.onInit();
    change(videos, status: RxStatus.empty());
  }

  void addVideo(Video video) {
    change(videos, status: RxStatus.loadingMore());
    if (File(video.file.path).lengthSync() != 0) {
      videos[video.name] = video;
    }
    change(
        videos,
        status: videos.isEmpty ? RxStatus.empty() : RxStatus.success()
    );
  }

  void removeVideo(String name) {
    videos.remove(name);
    change(
      videos,
      status: videos.isEmpty ? RxStatus.empty() : RxStatus.success()
    );
  }

  Future<void> listLocalVideoList(String user) async {
    final directory = await getApplicationDocumentsDirectory();
    Directory('${directory.path}/$user/videos/')
        .list()
        .forEach((f) async {
      addVideo(Video(name: f.path.split('/').last, file: XFile(f.path)));
    });
  }
}
