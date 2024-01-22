import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rom/controllers/app_controller.dart';
import 'package:rom/models/user_model.dart';

class SignUpPageController extends GetxController {
  final app = Get.find<AppController>();

  final formKey = GlobalKey<FormState>();
  final nameInputCtl = TextEditingController();
  final codeInputCtl = TextEditingController();
  final codeObscured = true.obs;
  final inProgress = false.obs;

  void clearInputs() {
    nameInputCtl.clear();
    codeInputCtl.clear();
    codeObscured.value = true;
  }

  void signup() {
    inProgress.value = true;
    if (formKey.currentState!.validate()) {
      app.signup(User(name: nameInputCtl.text, code: codeInputCtl.text)).then(
            (res) => res ? clearInputs() : {},
      );
    }
    inProgress.value = false;
  }

  String? nameInputValidator(value) {
    if (value == null || value.isEmpty) {
      return 'requires a valid name';
    }
    return null;
  }

  String? codeInputValidator(value) {
    if (value == null || value.isEmpty) {
      return 'requires a valid code';
    }
    return null;
  }
}
