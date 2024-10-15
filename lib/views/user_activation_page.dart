import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:dotted_border/dotted_border.dart";
import "package:animate_do/animate_do.dart";
import "dart:io";
import "../controllers/activation_controller.dart";

class UserActivationPage extends StatelessWidget {
  final ActivationController activationController =
      Get.put(ActivationController());

  UserActivationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // Image section (could be a logo or instruction image)
                Image.asset(
                  "./assets/images/logo.png", // Replace with your image path
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
                const SizedBox(height: 20),
                // Text description
                FadeInDown(
                  child: const Text(
                    "Activate your account by uploading an avatar photo. "
                    "This will be used as your profile picture.",
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black87,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 30),
                // Dotted rectangle with orange border
                InkWell(
                  onTap: activationController.pickImage,
                  child: DottedBorder(
                    color: Colors.orange,
                    strokeWidth: 2,
                    dashPattern: const [6, 3],
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.orange.shade50,
                      ),
                      child: Obx(() {
                        return activationController.imageFile.value == null
                            ? const Center(
                                child: Text(
                                  "Tap to upload your avatar",
                                  style: TextStyle(
                                      color: Colors.orange, fontSize: 16),
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  File(activationController
                                      .imageFile.value!.path),
                                  fit: BoxFit.cover,
                                ),
                              );
                      }),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Button to pick an image
                MaterialButton(
                  onPressed: activationController.onActivateButtonClicked,
                  color: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: const Text(
                    "Activate Account",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                // Button to return to the login page
                TextButton(
                  onPressed: () {
                    Get.offAllNamed('/login');
                  },
                  child: const Text(
                    "Back to Login",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
