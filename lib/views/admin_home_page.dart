import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:splitmate/services/user_service.dart";
import "package:splitmate/views/admin_activity_page.dart";
import "package:splitmate/views/admin_properties_page.dart";
import "package:splitmate/views/admin_service_page.dart";
import "package:splitmate/views/all_tenants_page.dart";
import "package:splitmate/views/profile_page.dart";
import "package:splitmate/widgets/sidebar.dart";

class AdminHomePage extends StatelessWidget {
  final RxInt currentBarIndex = 0.obs;

  final UserService userService = Get.find<UserService>();

  AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        leading: Builder(
          builder: (context) => IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: const Icon(Icons.menu)),
        ),
        title: const Text(
          "SplitMate Management System",
          style: TextStyle(fontSize: 18.0),
        ),
      ),
      body: Obx(() => IndexedStack(
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
                          Tab(text: "Properties"),
                          Tab(text: "Activity"),
                          Tab(text: "Tenants"),
                        ],
                        labelColor: Colors.black,
                        indicatorColor: Colors.orange,
                      ),
                    ),
                  ),
                  body: TabBarView(
                    children: [
                      AdminPropertiesPage(),
                      AdminActivityPage(),
                      AllTenantsPage()
                    ],
                  ),
                ),
              ),
              AdminServicePage(),
              ProfilePage()
            ],
          )),
      drawer: Sidebar(
        username: userService.userInfo?["name"] ??
            "Unknown", // Fetching username from GetStorage
        email: userService.userInfo?["email"] ?? "Unknown",
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
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: "Notification",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
            ),
          ],
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.grey,
        ),
      ),
    );
  }
}
