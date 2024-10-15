import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  final emailController = TextEditingController();

  void onSendCaptchaButtonPressed() {
    String content = emailController.text.trim();

    if (content.isEmpty || !GetUtils.isEmail(content)) {
      Get.snackbar(
        "Error",
        "Please input a valid email.",
        icon: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Icon(
            Icons.warning,
            color: Colors.orange,
            size: 30.0,
          ),
        ),
        padding: const EdgeInsets.all(15.0),
      );
    } else {
      Get.toNamed("/enter-captcha");
    }
    return;
  }
}
