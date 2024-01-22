import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rom/component/pose_card.dart';
import 'package:rom/component/text_input.dart';
import 'package:rom/controllers/app_controller.dart';
import 'package:rom/extensions/layout_extension.dart';
import 'package:rom/pages/video_page.dart';

class MainPage extends GetResponsiveView {
  MainPage({super.key});

  final app = Get.find<AppController>();

  @override
  Widget? phone() {
    if (app.signedInUser != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('RoMA-T'),
          actions: [
            IconButton(
                onPressed: () =>
                    app.videoListCtl.listLocalVideoList(app.signedInUser!.name),
                icon: const Icon(Icons.refresh))
          ],
        ),
        body: app.videoListCtl.obx(
          (videoList) => ListView.builder(
            itemCount: videoList?.length,
            itemBuilder: (context, index) {
              if (videoList == null) return null;
              final video = videoList.values.elementAt(index);
              return PoseCard(
                title: video.name,
                onTap: () {
                  Get.to(() => VideoPage(video: video));
                },
              ).marginSymmetric(horizontal: 10);
            },
          ),
          onError: (error) => Center(child: Text('error: $error')),
          onEmpty: Center(child: Image.asset('assets/images/empty list.png')),
        ),
        persistentFooterAlignment: AlignmentDirectional.center,
        persistentFooterButtons: [
          IconButton(
            onPressed: () => app.pickVideo(source: ImageSource.camera),
            icon: const Icon(Icons.camera_alt),
            tooltip: 'camera',
          ),
          IconButton(
            onPressed: () => app.pickVideo(source: ImageSource.gallery),
            icon: const Icon(Icons.photo),
            tooltip: 'gallery',
          ),
          IconButton(
            onPressed: () {
              Get.bottomSheet(
                serverSettingPanel(),
              );
            },
            icon: const Icon(Icons.cloud),
            iconSize: 30,
            tooltip: 'server settings',
          ),
          IconButton(
            onPressed: () {
              Get.bottomSheet(
                poseSettingPanel(),
              );
            },
            icon: const Icon(Icons.settings),
            iconSize: 30,
            tooltip: 'pose settings',
          ),
          IconButton(
            onPressed: app.signout,
            icon: const Icon(Icons.logout),
            iconSize: 30,
            tooltip: 'sign out',
          ),
        ],
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('RoMA-T'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Get.toNamed('/signin'),
              child: const Text('Sign In'),
            ).size(width: 200),
            ElevatedButton(
              onPressed: () => Get.toNamed('/signup'),
              child: const Text('Sign Up'),
            ).size(width: 200),
          ],
        ).size(width: screen.width, height: screen.height),
        persistentFooterAlignment: AlignmentDirectional.center,
        persistentFooterButtons: [
          IconButton(
            onPressed: () {
              Get.bottomSheet(
                serverSettingPanel(),
              );
            },
            icon: const Icon(Icons.cloud),
            iconSize: 30,
            tooltip: 'server settings',
          ),
        ],
      );
    }
  }

  serverSettingPanel() {
    return Card(
      child: Form(
        key: app.serverSettingFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextInput(
              label: "Auth Server",
              ctl: app.authServerAddressInputCtl,
              validator: app.serverAddressInputValidator,
            ),
            TextInput(
              label: "Pose Server",
              ctl: app.poseServerAddressInputCtl,
              validator: app.serverAddressInputValidator,
            ),
            ElevatedButton(onPressed: app.connect, child: const Text("connect"))
                .size(width: 250),
          ],
        ).size(width: 250, height: 250).center(),
      ),
    );
  }

  poseSettingPanel() {
    return Card(
      child: Form(
        key: app.poseSettingFormKey,
        child: Obx(() => Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Frame Rate').marginOnly(right: 20),
                    Expanded(
                      child: Slider(
                        label: '${app.poseFrameStep.value.toInt()}',
                        value: app.poseFrameStep.value,
                        onChanged: (value) => app.poseFrameStep.value = value,
                        min: 1,
                        max: 40,
                        divisions: 10,
                      ),
                    ),
                  ],
                ).paddingSymmetric(horizontal: 20),
                Wrap(
                  children: app.poseAnalyseAngles.entries
                      .map(
                        (angle) => CheckboxListTile(
                          title: Text(
                              angle.key.toLowerCase().replaceAll("_", " ")),
                          value: angle.value,
                          onChanged: (selected) => app.poseAnalyseAngles
                              .update(angle.key, (_) => selected ?? false),
                        ).size(width: 190),
                      )
                      .toList(),
                ),
              ],
            ).scrollable()),
      ).center(),
    );
  }
}
