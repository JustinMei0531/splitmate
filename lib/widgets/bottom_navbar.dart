import "package:flutter/material.dart";
import "package:get/get.dart";

class BottomNavBar extends StatelessWidget {
  final RxInt currentBarIndex = 0.obs;
  BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bolt),
              label: "Services",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
            ),
          ],
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.grey,
        ));
  }
}
