import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:animate_do/animate_do.dart';
import 'dart:io';
import 'package:splitmate/controllers/update_profile_controller.dart';

class UpdateProfilePage extends StatelessWidget {
  UpdateProfilePage({super.key});

  // Inject the UpdateProfileController
  final UpdateProfileController updateProfileController =
      Get.put(UpdateProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: updateProfileController.onBackButtonClicked,
        ),
        title: const Text(
          "Update Profile",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),

              // Avatar Upload Section
              FadeInDown(
                child: InkWell(
                  onTap: updateProfileController.pickImage,
                  child: DottedBorder(
                    color: Colors.orange,
                    strokeWidth: 2,
                    dashPattern: const [6, 3],
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(10),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.orange.shade50,
                      ),
                      child: Obx(() {
                        return updateProfileController.imageFile.value == null
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
                                  File(updateProfileController
                                      .imageFile.value!.path),
                                  fit: BoxFit
                                      .cover, // Change to cover for better fit
                                  height: double.infinity,
                                  width: double.infinity,
                                ),
                              );
                      }),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Name Field
              FadeInUp(
                delay: const Duration(microseconds: 800),
                duration: const Duration(milliseconds: 1500),
                child: buildStyledTextField(
                  "Name",
                  "Enter your name",
                  Icons.person,
                  updateProfileController.nameController,
                ),
              ),
              const SizedBox(height: 30),

              // Email Field
              FadeInUp(
                delay: const Duration(microseconds: 800),
                duration: const Duration(milliseconds: 1500),
                child: buildStyledTextField(
                  "Email",
                  "Your email",
                  Icons.email,
                  updateProfileController.emailController,
                ),
              ),
              const SizedBox(height: 30),

              // Phone Field
              FadeInUp(
                delay: const Duration(microseconds: 800),
                duration: const Duration(milliseconds: 1500),
                child: buildStyledTextField(
                  "Phone",
                  "Your phone number",
                  Icons.phone,
                  updateProfileController.phoneController,
                ),
              ),
              const SizedBox(height: 50),

              // Save Changes Button
              FadeInUp(
                delay: const Duration(milliseconds: 500),
                duration: const Duration(milliseconds: 1000),
                child: MaterialButton(
                  onPressed: () => updateProfileController.saveProfileInfo(),
                  height: 45,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  color: Colors.black,
                  child: Obx(() {
                    return updateProfileController.isLoading.value
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 1.0,
                          )
                        : const Text("Save Changes",
                            style: TextStyle(color: Colors.white));
                  }),
                ),
              ),
              const SizedBox(height: 30),

              // Cancel Button
              FadeInUp(
                delay: const Duration(milliseconds: 500),
                duration: const Duration(milliseconds: 1000),
                child: TextButton(
                  onPressed: () => Get.back(),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget for the styled text fields
  Widget buildStyledTextField(String label, String hint, IconData icon,
      TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
        labelText: label,
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.lightBlue, fontSize: 14.0),
        labelStyle: const TextStyle(
            color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400),
        prefixIcon: Icon(icon, color: Colors.black, size: 18),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        floatingLabelStyle: const TextStyle(color: Colors.black, fontSize: 18),
      ),
    );
  }
}
