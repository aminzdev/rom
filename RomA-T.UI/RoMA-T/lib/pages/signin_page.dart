import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rom/component/text_input.dart';
import 'package:rom/controllers/signin_page_controller.dart';
import 'package:rom/extensions/layout_extension.dart';

class SignInPage extends GetResponsiveView<SignInPageController> {
  SignInPage({super.key}) {
    Get.put(SignInPageController());
  }

  @override
  Widget? phone() {
    return Scaffold(
      body: Form(
        key: controller.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextInput(
              label: 'username',
              ctl: controller.nameInputCtl,
              validator: controller.nameInputValidator,
            ),
            ObscureTextInput(
              label: 'password',
              ctl: controller.codeInputCtl,
              validator: controller.codeInputValidator,
            ),
            ElevatedButton(
              onPressed: controller.signin,
              child: const Text('Sign In'),
            ).size(width: 250),
            ElevatedButton(
              onPressed: Get.back,
              child: const Text('Back'),
            ).size(width: 250),
          ],
        ),
      ).size(width: 250, height: 300).center(),
    );
  }
}
