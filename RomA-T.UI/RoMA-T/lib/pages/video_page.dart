import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rom/controllers/app_controller.dart';
import 'package:rom/controllers/video_page_controller.dart';
import 'package:rom/extensions/layout_extension.dart';
import 'package:rom/models/video_model.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends GetResponsiveView {
  VideoPage({super.key, required this.video}) {
    ctl = Get.put(VideoPageController(), tag: video.name);
    ctl.xVideoCtl.initializeVideoPlayer(video);
  }

  final Video video;
  late final VideoPageController ctl;

  final app = Get.find<AppController>();

  @override
  Widget? phone() {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: const Text('remove'),
            onPressed: () => {app.remove(video), Get.offAllNamed('/')},
            child: const Icon(
              Icons.delete_forever,
              color: Colors.black,
            ),
          ).marginOnly(right: 20),
          FloatingActionButton(
            heroTag: const Text('estimation'),
            onPressed: () => app.analyzeVideo(video),
            child: Obx(
              () => app.isPoseVideoAnalyzing[video.name] ?? false
                  ? const CircularProgressIndicator()
                  : const Icon(
                      Icons.accessibility,
                      color: Colors.black,
                    ),
            ),
          ).marginOnly(right: 20),
          FloatingActionButton(
            heroTag: const Text('analytics'),
            onPressed: () => app.isPoseVideoAnalyzed[video.name] ?? false
                ? {
                    ctl.xVideoCtl.isVideoPlaying.value
                        ? ctl.xVideoCtl.toggleVideoPlayback()
                        : {},
                    Get.toNamed('/pose',
                        arguments: app.estimatedPose[video.name]),
                  }
                : {},
            child: Obx(
              () => Icon(
                      Icons.analytics,
                      color: app.isPoseVideoAnalyzed[video.name] ?? false
                          ? Colors.green
                          : Colors.black,
                    ),
            ),
          ).marginOnly(right: 20),
          FloatingActionButton(
            heroTag: const Text('photos'),
            onPressed: () => app.isPoseVideoAnalyzed[video.name] ?? false
                ? {
                    ctl.xVideoCtl.isVideoPlaying.value
                        ? ctl.xVideoCtl.toggleVideoPlayback()
                        : {},
                    Get.toNamed('/photo',
                        arguments: app.estimatedPose[video.name]),
                  }
                : {},
            child: Obx(
              () => Icon(
                      Icons.photo_library,
                      color: app.isPoseVideoAnalyzed[video.name] ?? false
                          ? Colors.green
                          : Colors.black,
                    ),
            ),
          ).marginOnly(right: 20),
          FloatingActionButton(
            heroTag: const Text('playback'),
            onPressed: () => ctl.xVideoCtl.toggleVideoPlayback(),
            child: Obx(() => Icon(
                  ctl.xVideoCtl.isVideoPlaying.value
                      ? Icons.pause
                      : Icons.play_arrow,
                )),
          ),
        ],
      ).scrollable(scrollDirection: Axis.horizontal),
      body: Center(
        child: ctl.xVideoCtl.obx(
          (videoPlayerCtl) => VideoPlayer(videoPlayerCtl!),
        ),
      ),
    );
  }
}
