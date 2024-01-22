import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextInput extends GetView {
  const TextInput({
    super.key,
    this.label,
    this.ctl,
    this.validator,
  });

  final String? label;
  final TextEditingController? ctl;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: ctl,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }
}

class ObscureTextInputController extends GetxController {
  final obscureText = true.obs;
}

class ObscureTextInput extends GetView<ObscureTextInputController> {
  ObscureTextInput({super.key, this.ctl, this.label, this.validator}) {
    Get.put(ObscureTextInputController());
  }

  final String? label;
  final TextEditingController? ctl;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Obx(() => TextFormField(
      controller: ctl,
      validator: validator,
      obscureText: controller.obscureText.value,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          onPressed: () =>
          controller.obscureText.value = !controller.obscureText.value,
          icon: Icon(
            controller.obscureText.value
                ? Icons.visibility_off
                : Icons.visibility,
          ),
        ),
      ),
    ));
  }
}
