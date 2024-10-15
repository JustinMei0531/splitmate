import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';

class EnterCaptchaPage extends StatelessWidget {
  const EnterCaptchaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool shouldExit = await Get.dialog(
          AlertDialog(
            title: const Text("Exit Page"),
            content: const Text("Are you sure you want to go back to the login page?"),
            actions: [
              TextButton(
                onPressed: () => Get.back(result: false), // Close the dialog and return false
                child: const Text("No"),
              ),
              TextButton(
                onPressed: () => Get.back(result: true), // Close the dialog and return true
                child: const Text("Yes"),
              ),
            ],
          ),
        ) ?? false;

        if (shouldExit) {
          Get.offAllNamed("/login"); // Navigate back to the login page and clear the stack
        }

        return false; // Prevent the default pop action
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(height: 50),
                  // Image Section
                  FadeInDown(
                    child: Image.asset(
                      "./assets/images/logo.png", // Replace with your image path
                      height: MediaQuery.of(context).size.height * 0.3, // Adaptive image height
                    ),
                  ),
                  const SizedBox(height: 50),
                  FadeInDown(
                    child: const Text(
                      "Enter Captcha",
                      style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20),
                  FadeInDown(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        "Enter the captcha and set a new password",
                        style: TextStyle(color: Colors.grey.shade700),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  FadeInDown(
                    child: TextField(
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black, width: 1.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "Captcha",
                        hintText: "Enter Captcha",
                        hintStyle: const TextStyle(color: Colors.lightBlue, fontSize: 14.0),
                        labelStyle: const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400),
                        prefixIcon: const Icon(Icons.verified_user, color: Colors.black, size: 18),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey, width: 2),
                            borderRadius: BorderRadius.circular(10)),
                        floatingLabelStyle: const TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  FadeInDown(
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black, width: 1.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "New Password",
                        hintText: "Enter New Password",
                        hintStyle: const TextStyle(color: Colors.lightBlue, fontSize: 14.0),
                        labelStyle: const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400),
                        prefixIcon: const Icon(Icons.lock, color: Colors.black, size: 18),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey, width: 2),
                            borderRadius: BorderRadius.circular(10)),
                        floatingLabelStyle: const TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  FadeInDown(
                    child: MaterialButton(
                      onPressed: () => {},
                      color: Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      minWidth: double.infinity,
                      child: const Text(
                        "Reset Password",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  FadeInDown(
                    child: TextButton(
                      onPressed: () {
                        Get.toNamed("/login");
                      },
                      child: const Text(
                        "Back to login",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
