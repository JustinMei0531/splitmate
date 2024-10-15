import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:splitmate/controllers/login_controller.dart';
import 'package:splitmate/services/user_service.dart';
import 'package:splitmate/views/activity_page.dart';
import 'package:splitmate/views/dashboard_page.dart';
import 'package:splitmate/views/profile_page.dart';
import 'package:splitmate/views/request_page.dart';
import 'package:splitmate/views/service_page.dart';
import 'package:splitmate/widgets/sidebar.dart';

class UserHomePage extends StatelessWidget {
  final RxInt currentBarIndex = 0.obs;
  final LoginController loginController = Get.put(LoginController());

  final UserService userService = Get.find<UserService>();

  UserHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve user info from GetStorage
    Map<String, dynamic> userInfo = userService.userInfo ?? {};
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            ElevatedButton.icon(
              onPressed: () {
                _showPropertySelector(context);
              },
              label: const Text(
                "Property name...",
                style: TextStyle(color: Colors.black),
              ),
              icon: const Icon(Icons.other_houses_outlined),
              style: const ButtonStyle(
                  iconColor: WidgetStatePropertyAll(Colors.black)),
              iconAlignment: IconAlignment.end,
            ),
          ],
        ),
      ),
      body: Obx(() {
        return IndexedStack(
          index: currentBarIndex.value,
          children: [
            DefaultTabController(
              length: 3,
              child: Scaffold(
                appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(48.0),
                  child: AppBar(
                    backgroundColor: Colors.orange,
                    bottom: const TabBar(
                      tabs: [
                        Tab(text: "Dashboard"),
                        Tab(text: "Activity"),
                        Tab(text: "Requests"),
                      ],
                      labelColor: Colors.black,
                      indicatorColor: Colors.orange,
                    ),
                  ),
                ),
                body: TabBarView(
                  children: [
                    DashboardPage(),
                    ActivityPage(),
                    RequestPage(),
                  ],
                ),
              ),
            ),
            ServicePage(),
            ProfilePage(),
          ],
        );
      }),
      drawer: Sidebar(
        username:
            userInfo["name"] ?? "Unknown", // Fetching username from GetStorage
        email: userInfo["email"] ?? "Unknown",
        avatarURL: userService.avatarUrl ??
            "https://via.placeholder.com/150", // Fetching email from GetStorage
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentBarIndex.value,
          onTap: (int index) {
            currentBarIndex.value = index;
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bolt),
              label: 'Services',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.grey,
        ),
      ),
    );
  }

  void _showPropertySelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                'My properties',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              ListTile(
                leading: const Icon(Icons.apartment_outlined, size: 30),
                title: const Text("pProperty location"),
                subtitle: const Text("Adelaide, SA 5005"),
                trailing: const Icon(Icons.check_circle, color: Colors.blue),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
