import "package:firebase_core/firebase_core.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:get_storage/get_storage.dart";
import "package:splitmate/services/user_service.dart";
import "package:splitmate/views/admin_home_page.dart";
import "package:splitmate/views/login_page.dart";
import "package:splitmate/views/apply_page.dart";
import "package:splitmate/views/input_email_page.dart";
import "package:splitmate/views/reset_password_page.dart";
import "package:splitmate/views/splash_screen.dart";
import "package:splitmate/views/user_home_page.dart";
import "package:splitmate/views/user_activation_page.dart";
import "package:splitmate/views/update_profile_page.dart";

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "SplitMate",
      debugShowCheckedModeBanner: false,

      // Register app routers
      initialRoute: "/splash",

      getPages: <GetPage<dynamic>>[
        GetPage(name: "/splash", page: () => const SplashScreen()),
        GetPage(name: "/login", page: () => LoginPage()),
        GetPage(name: "/apply", page: () => ApplyPage()),
        GetPage(name: "/input-email", page: () => InputEmailPage()),
        GetPage(name: "/enter-captcha", page: () => EnterCaptchaPage()),
        GetPage(name: "/user-home", page: () => UserHomePage()),
        GetPage(name: "/activate", page: () => UserActivationPage()),
        GetPage(name: "/admin-home", page: () => AdminHomePage()),
        GetPage(name: "/update-profile", page: () => UpdateProfilePage()),
      ],
    );
  }
}

void main(List<String> args) async {
  // Initialize Flutter widgets
  WidgetsFlutterBinding.ensureInitialized();
  // Start Firebase service
  await Firebase.initializeApp();
  // Initialize GetX driver
  await GetStorage.init();
  // Register user service
  Get.put(UserService());
  runApp(const App());
}
