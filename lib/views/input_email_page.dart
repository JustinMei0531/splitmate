import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:animate_do/animate_do.dart";
import "package:splitmate/controllers/reset_password_controller.dart";

class InputEmailPage extends StatelessWidget {
  final ResetPasswordController controller = Get.put(ResetPasswordController());
  InputEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // const SizedBox(height: 30),
                // Image Section
                FadeInDown(
                  child: Image.asset(
                    "./assets/images/logo.png", // Replace with your image path
                    height: MediaQuery.of(context).size.height *
                        0.3, // Adaptive image height
                    // fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                FadeInDown(
                  child: const Text(
                    "Reset Password",
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                FadeInDown(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      "Enter your email address to receive a captcha to reset your password",
                      style: TextStyle(color: Colors.grey.shade700),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                FadeInDown(
                  child: TextField(
                    controller: controller.emailController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 1.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Email",
                      hintText: "Your email",
                      hintStyle: const TextStyle(
                          color: Colors.lightBlue, fontSize: 14.0),
                      labelStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                      prefixIcon: const Icon(Icons.email,
                          color: Colors.black, size: 18),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 2),
                          borderRadius: BorderRadius.circular(10)),
                      floatingLabelStyle:
                          const TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(height: 30.0),
                FadeInDown(
                  child: MaterialButton(
                    onPressed: () => controller.onSendCaptchaButtonPressed(),
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    minWidth: double.infinity,
                    child: const Text(
                      "Send Captcha",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                // Back to Login Button
                FadeInDown(
                  child: TextButton(
                    onPressed: () {
                      Get.toNamed("/login"); // Redirect to the login page
                    },
                    child: const Text(
                      "Back to Login",
                      style: TextStyle(color: Colors.blue),
                    ),
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
