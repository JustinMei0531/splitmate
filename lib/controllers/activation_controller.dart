import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:splitmate/services/user_service.dart';

class ActivationController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  final Rx<XFile?> imageFile = Rx<XFile?>(null);

  // User service
  UserService userService = Get.find<UserService>();

  // Firebase instances
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Function to pick an image from the gallery
  Future<void> pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        imageFile.value = pickedFile;

        // Show success message
        Get.snackbar(
          "Success",
          "Avatar picked successfully!",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to pick an image: $e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Function to handle activation by uploading the avatar
  // Function to handle activation by uploading the avatar
  Future<void> onActivateButtonClicked() async {
    debugPrint("Activate button pressed!");

    if (imageFile.value == null) {
      Get.snackbar(
        "Error",
        "Please select an image to activate your account.",
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    try {
      debugPrint("Image selected: ${imageFile.value!.path}");

      // Get the currently logged-in user
      User? user = _auth.currentUser;
      if (user == null) {
        Get.snackbar(
          "Error",
          "No user is logged in. Please log in again.",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      File image = File(imageFile.value!.path);
      int fileSize = await image.length();
      debugPrint("File size: $fileSize bytes");

      if (fileSize > 5 * 1024 * 1024) {
        Get.snackbar(
          "Error",
          "The selected image is too large. Please select an image smaller than 5MB.",
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
        return;
      }

      String uid = user.uid;
      String fileName = "avatars/$uid-${imageFile.value!.name}";
      debugPrint("Uploading to Firebase Storage: $fileName");

      // Upload image to Firebase Storage
      Reference storageRef = _storage.ref().child(fileName);
      UploadTask uploadTask = storageRef.putFile(image);

      // Wait for upload to complete and catch any errors
      TaskSnapshot storageSnapshot = await uploadTask.whenComplete(() {
        debugPrint("Upload completed!");
      }).catchError((error) {
        debugPrint("Upload failed: $error");
        Get.snackbar(
          "Upload Error",
          "Failed to upload image: $error",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      });

      debugPrint("Getting download URL...");
      String downloadUrl = await storageSnapshot.ref.getDownloadURL();
      debugPrint("Download URL: $downloadUrl");

      // Update Firestore user document with the avatar URL
      await _firestore.collection('users').doc(uid).update({
        'avatar_url': downloadUrl,
        'first_login': false, // Mark the account as activated
      });

      // Update user avatar URL
      userService.updateAvatarUrl(downloadUrl);

      Get.snackbar(
        "Success",
        "Account activated successfully!",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      Get.offAllNamed(
          "/user-home"); // Navigate to the home page after activation
    } catch (e) {
      debugPrint("Error: $e");
      Get.snackbar(
        "Error",
        "Failed to activate your account: $e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
