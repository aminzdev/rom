import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rom/controllers/app_controller.dart';
import 'package:rom/pages/analysed_pose_page.dart';
import 'package:rom/pages/main_page.dart';
import 'package:rom/pages/photo_page.dart';
import 'package:rom/pages/signin_page.dart';
import 'package:rom/pages/signup_page.dart';
import 'package:rom/service/auth_service.dart';
import 'package:rom/service/pose_service.dart';

void main() async {
  await GetStorage.init();
  Get.put(AuthService());
  Get.put(PoseService());
  Get.put(AppController());

  runApp(GetMaterialApp(
    initialRoute: '/',
    theme: ThemeData.light(useMaterial3: true),
    darkTheme: ThemeData.dark(useMaterial3: true),
    themeMode: ThemeMode.light,
    getPages: [
      GetPage(name: '/', page: MainPage.new),
      GetPage(name: '/signup', page: SignUpPage.new),
      GetPage(name: '/signin', page: SignInPage.new),
      GetPage(name: '/pose', page: AnalysedPosePage.new),
      GetPage(name: '/photo', page: PhotoPage.new),
    ],
  ));
}
