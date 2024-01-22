import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rom/controllers/camera_controller.dart';
import 'package:rom/controllers/video_list_controller.dart';
import 'package:rom/models/estimated_pose.dart';
import 'package:rom/models/user_model.dart';
import 'package:rom/models/video_model.dart';
import 'package:rom/service/auth_service.dart';
import 'package:rom/service/pose_service.dart';

class AppController extends GetxController {
  final auth = Get.find<AuthService>();
  final pose = Get.find<PoseService>();
  User? signedInUser;

  final mem = GetStorage();

  final serverSettingFormKey = GlobalKey<FormState>();
  final poseSettingFormKey = GlobalKey<FormState>();
  final authServerAddressInputCtl = TextEditingController();
  final poseServerAddressInputCtl = TextEditingController();
  final connectingInProgress = false.obs;

  final poseFrameStep = 20.0.obs;
  final poseAnalyseAngles = <String, bool>{
    "LEFT_SHOULDER": true,
    "RIGHT_SHOULDER": true,
    "LEFT_ELBOW": true,
    "RIGHT_ELBOW": true,
    "LEFT_HIP": true,
    "RIGHT_HIP": true,
    "LEFT_KNEE": true,
    "RIGHT_KNEE": true,
  }.obs;

  late final VideoListController videoListCtl;
  late final CameraController _cameraController;

  final isPoseVideoAnalyzed = <String, bool>{}.obs;
  final isPoseVideoAnalyzing = <String, bool>{}.obs;
  final estimatedPose = <String, EstimatedPose>{};

  @override
  void onInit() async {
    super.onInit();
    authServerAddressInputCtl.text =
        mem.read('auth_server_address') ?? 'localhost';
    poseServerAddressInputCtl.text =
        mem.read('pose_server_address') ?? 'localhost';

    videoListCtl = Get.put(VideoListController());
    _cameraController = Get.put(CameraController());

    connect(checkValidation: false);
    await signin(
            User(name: mem.read('user') ?? '', code: mem.read('code') ?? ''))
        .then((_) async {
      if (signedInUser != null) {
        await videoListCtl.listLocalVideoList(signedInUser!.name);
      }
    });
  }

  void connect({bool checkValidation = true}) async {
    connectingInProgress.value = true;
    if (!checkValidation || serverSettingFormKey.currentState!.validate()) {
      await auth.ping(authServerAddressInputCtl.text).then(
            (res) => res.when(
              (success) {
                _showSuccess("connected to auth server");
                mem.write(
                  'auth_server_address',
                  authServerAddressInputCtl.text,
                );
              },
              (error) => _showError("could not connect to auth server"),
            ),
          );
      await pose.ping(poseServerAddressInputCtl.text).then(
            (res) => res.when(
              (success) {
                _showSuccess("connected to pose server");
                mem.write(
                  'pose_server_address',
                  poseServerAddressInputCtl.text,
                );
              },
              (error) => _showError("could not connect to pose server"),
            ),
          );
    }
    connectingInProgress.value = false;
  }

  Future<bool> signup(User user) async {
    final res = await auth.signup(name: user.name, code: user.code);
    return res.when(
      (success) {
        _showSuccess("${user.name} signed up");
        Get.toNamed('/signin');
        return true;
      },
      (error) {
        _showError('${error.message}');
        return false;
      },
    );
  }

  Future<bool> signin(User user) async {
    if (user.name.isEmpty || user.code.isEmpty) {
      return Future.value(false);
    }
    final res = await auth.signin(name: user.name, code: user.code);
    return res.when(
      (success) async {
        signedInUser = user;
        await videoListCtl.listLocalVideoList(signedInUser!.name);
        Get.offAllNamed('/');
        return true;
      },
      (error) {
        _showError('${error.message}');
        return false;
      },
    );
  }

  void signout() {
    auth.signout().then((res) => res.when(
          (success) {
            signedInUser = null;
            Get.offAllNamed('/');
          },
          (error) => _showError('${error.message}'),
        ));
  }

  String? serverAddressInputValidator(value) {
    if (value == null || value.isEmpty) {
      return 'requires a valid host address';
    }
    return null;
  }

  void pickVideo({required ImageSource source}) {
    _cameraController.pickVideo(source: source).then(
          (res) => res.when(
            (video) => videoListCtl.addVideo(video),
            (error) => _showError(error),
          ),
        );
  }

  void analyzeVideo(Video video) async {
    isPoseVideoAnalyzing[video.name] = true;
    isPoseVideoAnalyzed[video.name] = false;
    isPoseVideoAnalyzing.update(video.name, (_) => true);
    final res = await pose.analyseVideo(
      user: signedInUser!.name,
      name: video.name,
      video: video.file,
      frameStep: poseFrameStep.value,
      joints: poseAnalyseAngles,
      useCached: isPoseVideoAnalyzed[video.name] ?? false,
    );
    res.when(
      (e) => {
        estimatedPose[video.name] = e,
        isPoseVideoAnalyzed.update(video.name, (_) => true),
      },
      (error) => _showError('${error.message}'),
    );
    isPoseVideoAnalyzing.update(video.name, (_) => false);
  }

  void remove(Video video) async {
    isPoseVideoAnalyzed.remove(video.name);
    isPoseVideoAnalyzing.remove(video.name);
    estimatedPose.remove(video.name);

    videoListCtl.removeVideo(video.name);

    try {
      final directory = await getApplicationDocumentsDirectory();
      File('${directory.path}/${signedInUser!.name}/videos/${video.name}').delete();
    } catch (e) {
      debugPrint('$e');
    }
  }

  void _showError(String message) {
    Get.showSnackbar(GetSnackBar(
      message: message,
      duration: const Duration(seconds: 2),
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red.shade400,
      borderRadius: 30,
      margin: const EdgeInsets.all(15),
      dismissDirection: DismissDirection.horizontal,
    ));
  }

  void _showSuccess(String message) {
    Get.showSnackbar(GetSnackBar(
      message: message,
      duration: const Duration(seconds: 2),
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green.shade400,
      borderRadius: 30,
      margin: const EdgeInsets.all(15),
      dismissDirection: DismissDirection.horizontal,
    ));
  }
}
