import 'package:get/get.dart';
import 'package:rom/controllers/video_player_controller.dart';
import 'package:rom/service/pose_service.dart';

class VideoPageController extends GetxController {
  final poseService = Get.find<PoseService>();
  late final XVideoPlayerController xVideoCtl;

  @override
  void onInit() {
    super.onInit();
    xVideoCtl = Get.put(XVideoPlayerController());
  }
}
