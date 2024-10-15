import "package:get/get.dart";
import "package:flutter/material.dart";

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () => Get.offAllNamed("/login"));
    return Scaffold(
      backgroundColor: Colors.orange,
      body: Center(
        child: Image.asset(
          "./assets/images/login_image01.png",
          width: 500,
          height: 500,
        ),
      ),
    );
  }
}
