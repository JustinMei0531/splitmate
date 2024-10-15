import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:splitmate/services/user_service.dart';

class UpdateProfileController extends GetxController {
  // Inject UserService
  final UserService userService = Get.find<UserService>();

  // Controllers for text fields
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;

  // Reactive loading state and image file
  final RxBool isLoading = false.obs;
  final Rx<File?> imageFile = Rx<File?>(null);

  // Firebase instances
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  @override
  void onInit() {
    super.onInit();
    // Initialize text controllers with existing user data
    nameController =
        TextEditingController(text: userService.userInfo?['name'] ?? '');
    emailController =
        TextEditingController(text: userService.userInfo?['email'] ?? '');
    phoneController =
        TextEditingController(text: userService.userInfo?['phone'] ?? '');
  }

  @override
  void onClose() {
    // Dispose controllers when the controller is destroyed
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.onClose();
  }

  // Pick image using ImagePicker
  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File selectedFile = File(pickedFile.path);

      // Check if file size is less than 5MB
      int fileSize = await selectedFile.length(); // Get file size in bytes
      if (fileSize > 5 * 1024 * 1024) {
        // 5MB in bytes
        Get.snackbar(
          "Error",
          "The selected image is too large. Please select an image smaller than 5MB.",
          backgroundColor: Colors.orange,
          colorText: Colors.white,
          icon: const Icon(Icons.warning, color: Colors.white),
        );
        return; // Exit the function if file size is too large
      }

      // Assign image file if it passes the size check
      imageFile.value = selectedFile;
      Get.snackbar(
        "Success",
        "Image selected successfully.",
        backgroundColor: Colors.green,
        colorText: Colors.white,
        icon: const Icon(Icons.check_circle, color: Colors.white),
      );
    }
  }

  // Save profile information and avatar
  Future<void> saveProfileInfo() async {
    // Update loading state
    isLoading.value = true;

    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String phone = phoneController.text.trim();

    try {
      // Check if the provided email is already used by another user
      QuerySnapshot emailCheck = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      if (emailCheck.docs.isNotEmpty && email != _auth.currentUser?.email) {
        Get.snackbar(
          "Error",
          "The email address is already in use by another account.",
          backgroundColor: Colors.orange,
          colorText: Colors.white,
          icon: const Icon(Icons.warning, color: Colors.white),
        );
        isLoading.value = false;
        return;
      }

      // Get the currently logged-in user
      User? currentUser = _auth.currentUser;

      // Fetch the existing avatar URL from Firestore
      String? oldAvatarUrl = userService.userInfo?['avatar_url'];

      // Upload new avatar to Firebase Storage if a new image is selected
      String? newAvatarUrl;
      if (imageFile.value != null) {
        // If there's an old avatar, delete it
        if (oldAvatarUrl != null && oldAvatarUrl.isNotEmpty) {
          await deleteOldAvatar(oldAvatarUrl);
        }

        // Define the file name for the new avatar
        String fileName =
            "avatars/${currentUser!.uid}-${imageFile.value!.path.split('/').last}";
        Reference storageRef = _storage.ref().child(fileName);

        // Upload the avatar file
        UploadTask uploadTask = storageRef.putFile(imageFile.value!);
        TaskSnapshot snapshot = await uploadTask;
        newAvatarUrl = await snapshot.ref.getDownloadURL();

        // Update UserService immediately with new avatar URL
        userService.updateAvatarUrl(newAvatarUrl);
      }

      // Update Firebase Authentication profile
      await currentUser!.verifyBeforeUpdateEmail(email);
      await currentUser.updateDisplayName(name);

      // Update user profile information in Firestore
      await _firestore.collection('users').doc(currentUser.uid).update({
        'name': name,
        'email': email,
        'phone': phone,
        'avatar_url': newAvatarUrl ?? oldAvatarUrl, // Use new or old avatar URL
      });

      // Update local storage with new user info in UserService
      userService.saveUserInfo({
        'name': name,
        'email': email,
        'phone': phone,
        'avatar_url': newAvatarUrl ?? oldAvatarUrl,
      });

      // Show success message
      Get.snackbar(
        "Success",
        "Profile updated successfully in both Authentication and Firestore.",
        icon: const Icon(Icons.check_circle, color: Colors.white),
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      // Handle any errors that occur during the update
      Get.snackbar(
        "Error",
        "Failed to update profile: $e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        icon: const Icon(Icons.error, color: Colors.white),
      );
    } finally {
      // Stop loading state
      isLoading.value = false;
    }
  }

  // Delete the old avatar from Firebase Storage
  Future<void> deleteOldAvatar(String oldAvatarUrl) async {
    try {
      Reference oldRef = _storage.refFromURL(oldAvatarUrl);
      await oldRef.delete();
      debugPrint("Old avatar deleted successfully: $oldAvatarUrl");
    } catch (e) {
      debugPrint("Failed to delete old avatar: $e");
    }
  }

  // Back to previous page
  void onBackButtonClicked() {
    Get.back();
  }
}
