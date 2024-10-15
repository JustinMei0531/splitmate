import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:splitmate/controllers/sidebar_controller.dart";
import "package:splitmate/services/user_service.dart";

class Sidebar extends StatelessWidget {
  String username;
  String email;

  String avatarURL;

  Sidebar(
      {required this.username,
      required this.email,
      required this.avatarURL,
      super.key});

  final SidebarController sidebarController = Get.put(SidebarController());

  final UserService userService = Get.find<UserService>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Colors.orange),
              accountName: Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 8.0, 0.0, 0.0),
                child: Text(
                  username,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              accountEmail: Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                child: Text(
                  email,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              currentAccountPicture: InkWell(
                onTap: sidebarController.onAvatarClicked,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(avatarURL),
                ),
              )),
          DrawerItem(
            icon: Icons.chat,
            title: "Chat",
            onTap: () {
              Get.toNamed("/chat");
            },
          ),
          DrawerItem(
            icon: Icons.settings,
            title: "Settings",
            onTap: () {
              Get.toNamed("/settings");
            },
          ),
          DrawerItem(
            icon: Icons.support,
            title: "Support",
            onTap: () {
              Get.toNamed("/support");
            },
          ),
          DrawerItem(
            icon: Icons.logout,
            title: "Logout",
            onTap: () {
              Get.offAllNamed("/login");
              userService.clearUserData();
              return;
            },
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "SplitMate 1.0.0",
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const DrawerItem({
    required this.icon,
    required this.title,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }
}
