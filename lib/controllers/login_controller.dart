import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  // Firebase instances
  final FirebaseAuth _auth = FirebaseAuth.instance;
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

      // Sign in with Firebase Authentication
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      debugPrint(
          'Login successful for user: ${userCredential.user?.email}'); // Debug log

      if (userCredential.user != null) {
        // Fetch user data from Firestore
        DocumentSnapshot userDoc = await _firestore
            .collection('users')
            .doc(userCredential.user!.uid)
            .get();

        if (userDoc.exists) {
          debugPrint('User data fetched successfully'); // Debug log

          // Retrieve the role field from Firestore
          Map<String, dynamic> userData =
              userDoc.data() as Map<String, dynamic>;
          int role = userData['role'] ?? 0; // Default role is 0 (regular user)
          bool isFirstLogin = userData['first_login']!;

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
          debugPrint('User document not found in Firestore'); // Debug log
          Get.snackbar("Error", "User information not found in Firestore.");
        }
      }
    } on FirebaseAuthException catch (e) {
      debugPrint('FirebaseAuthException: ${e.message}'); // Debug log
      Get.snackbar(
        "Login Error",
        e.message ?? "An error occurred during login.",
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
