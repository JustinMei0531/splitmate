import "package:get/get.dart";

class SidebarController extends GetxController {
  SidebarController();

  void onAvatarClicked() {
    Get.toNamed("/update-profile");
    return;
  }
}
