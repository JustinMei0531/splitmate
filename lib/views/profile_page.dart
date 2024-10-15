import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:splitmate/controllers/login_controller.dart";
import "package:splitmate/services/user_service.dart";
import "package:splitmate/utils/avatar_utils.dart";

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final LoginController loginController = Get.put(LoginController());

  final UserService userService = Get.find<UserService>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // User Profile Card
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[
                    // Profile Icon or Image
                    CircleAvatar(
                      radius: 28.0,
                      backgroundColor: Colors.orange,
                      child: Text(
                        getAvatarDisplay(
                            userService.userInfo?["name"] ?? "known"),
                        style: const TextStyle(
                            fontSize: 12.0, color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    // Profile Name and Email
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          userService.userInfo?["email"] ?? "Unknown",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          userService.userInfo?["name"] ?? "Unknown",
                          style: const TextStyle(
                              fontSize: 14.0, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            // Personal Details Section
            const Text(
              "Personal details",
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Name
                    const Text(
                      "NAME",
                      style: TextStyle(fontSize: 12.0, color: Colors.grey),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      userService.userInfo?["name"] ?? "Unknown",
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    const Divider(),
                    // Email
                    const Text(
                      "EMAIL",
                      style: TextStyle(fontSize: 12.0, color: Colors.grey),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      userService.userInfo?["email"] ?? "Unknown",
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    const Divider(),
                    // Phone
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              "PHONE",
                              style:
                                  TextStyle(fontSize: 12.0, color: Colors.grey),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              userService.userInfo?["phone"] ?? "Unknown",
                              style: const TextStyle(fontSize: 16.0),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Divider(),
                    // Date of Birth (DOB)
                    const Text(
                      "DOB",
                      style: TextStyle(fontSize: 12.0, color: Colors.grey),
                    ),
                    const SizedBox(height: 4.0),
                    const Text(
                      "-",
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
