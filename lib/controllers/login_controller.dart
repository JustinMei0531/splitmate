import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../utils/validation_utils.dart';
import '../../services/user_service.dart';

class LoginController extends GetxController {
  // Image list for the login page slideshow
  final List<String> images = [
    "./assets/images/login_image01.png",
    "./assets/images/login_image02.png",
    "./assets/images/login_image03.png",
    "./assets/images/login_image04.png",
  ];

  // Text controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwdController = TextEditingController();

  // Loading state
  final RxBool isLoading = false.obs;

  // Error messages
  RxString emailError = "".obs;
  RxString pwdError = "".obs;

  RxInt activationIndex = 0.obs;
  Timer? timer;

  // Inject UserService
  final UserService _userService = Get.find<UserService>();

  // Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      activationIndex.value = (activationIndex.value + 1) % images.length;
    });
  }

  // Method to check if the text format is valid
  bool checkTextFormat() {
    if (emailController.text.isEmpty || !isValidEmail(emailController.text)) {
      emailError.value = "Invalid email!";
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
      return false;
    }
    if (pwdController.text.isEmpty) {
      pwdError.value = "Password is empty!";
      Get.snackbar(
        "Error",
        "Please input your password.",
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
    }
    return true;
  }

  // Method to handle login button press with role-based navigation
  void onLoginButtonPressed() async {
    if (!checkTextFormat()) return;

    String email = emailController.text.trim();
    String password = pwdController.text.trim();

    try {
      isLoading.value = true; // Start loading

      debugPrint('Attempting to log in with email: $email'); // Debug log

      // Check if the email and password exist in Firestore
      QuerySnapshot userSnapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .where('password', isEqualTo: password)
          .get();

      if (userSnapshot.docs.isNotEmpty) {
        DocumentSnapshot userDoc = userSnapshot.docs.first;
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

        debugPrint('Login successful for user: ${userData['email']}');

        // Retrieve the role field from Firestore
        int role = userData['role'] ?? 0; // Default role is 0 (regular user)
        bool isFirstLogin = userData['first_login'] ?? true;

        if (isFirstLogin) {
          Get.offAllNamed("/activate");
          return;
        }

        // Save user information locally
        _userService.saveUserInfo(userData);

        Get.snackbar(
          "Success",
          "Login successful.",
          icon: const Padding(
            padding: EdgeInsets.all(10.0),
            child: Icon(
              Icons.verified,
              color: Colors.green,
              size: 30.0,
            ),
          ),
          padding: const EdgeInsets.all(15.0),
        );

        // Navigate to different pages based on role
        switch (role) {
          case 1: // Admin
            Get.offAllNamed("/admin-home");
            break;
          default: // Regular user
            Get.offAllNamed("/user-home");
        }
      } else {
        // No user found with the provided email and password
        Get.snackbar(
          "Error",
          "Invalid email or password.",
          icon: const Padding(
            padding: EdgeInsets.all(10.0),
            child: Icon(
              Icons.error,
              color: Colors.red,
              size: 30.0,
            ),
          ),
          padding: const EdgeInsets.all(15.0),
        );
      }
    } catch (e) {
      debugPrint('Error logging in: $e'); // Debug log
      Get.snackbar(
        "Login Error",
        "An error occurred during login. Please try again.",
        icon: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Icon(Icons.error, color: Colors.red, size: 30.0),
        ),
        padding: const EdgeInsets.all(15.0),
      );
    } finally {
      isLoading.value = false; // Stop loading
    }
  }

  void onApplyButtonPressed() {
    Get.offAllNamed("/apply");
  }

  void onForgetPasswordButtonPressed() {
    Get.offAllNamed("/input-email");
  }
}
