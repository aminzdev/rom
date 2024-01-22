import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rom/models/video_model.dart';
import 'package:video_player/video_player.dart';

class XVideoPlayerController extends GetxController
    with StateMixin<VideoPlayerController> {
  late VideoPlayerController _controller;

  void initializeVideoPlayer(Video video) async {
    final videoFile = File(video.file.path);

    debugPrint('\n\n\n video: ${video.name} ${videoFile.existsSync()} \n\n\n');

    _controller = VideoPlayerController.file(videoFile);
    await _controller.initialize();
    await _controller.setLooping(true);
    change(_controller, status: RxStatus.success());
  }

  final isVideoPlaying = false.obs;

  void toggleVideoPlayback() {
    if (_controller.value.isPlaying) {
      _controller.pause();
    } else {
      _controller.play();
    }
    isVideoPlaying.value = _controller.value.isPlaying;
  }

  @override
  void onClose() {
    _controller.dispose();
  }
}
