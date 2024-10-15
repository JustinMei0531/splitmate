import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:animate_do/animate_do.dart";
import "package:splitmate/controllers/apply_controller.dart";

class ApplyPage extends StatelessWidget {
  // Initialize the controller
  final ApplyController controller = Get.put(ApplyController());

  ApplyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          true, // Ensure the screen resizes when the keyboard appears
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Image.asset(
                  "./assets/images/login_image01.png",
                  height: MediaQuery.of(context).size.height *
                      0.3, // Adaptive image height
                ),
                const SizedBox(height: 50),
                FadeInDown(
                  child: const Text(
                    "Apply",
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                FadeInDown(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      "Enter your details to apply to become a new tenant",
                      style: TextStyle(color: Colors.grey.shade700),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                FadeInDown(
                  child: TextField(
                    controller:
                        controller.nameController, // Bind the name controller
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 1.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Name",
                      hintText: "Your name",
                      hintStyle: const TextStyle(
                          color: Colors.lightBlue, fontSize: 14.0),
                      labelStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                      prefixIcon: const Icon(Icons.person,
                          color: Colors.black, size: 18),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 2),
                          borderRadius: BorderRadius.circular(10)),
                      floatingLabelStyle:
                          const TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                FadeInDown(
                  child: TextField(
                    controller:
                        controller.emailController, // Bind the email controller
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 1.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Email",
                      hintText: "Your email",
                      hintStyle: const TextStyle(
                          color: Colors.lightBlue, fontSize: 14.0),
                      labelStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                      prefixIcon: const Icon(Icons.email,
                          color: Colors.black, size: 18),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 2),
                          borderRadius: BorderRadius.circular(10)),
                      floatingLabelStyle:
                          const TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                FadeInDown(
                  child: TextField(
                    controller: controller
                        .passwordController, // Bind the password controller
                    obscureText: true,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 1.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Password",
                      hintText: "Enter your password",
                      hintStyle: const TextStyle(
                          color: Colors.lightBlue, fontSize: 14.0),
                      labelStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                      prefixIcon:
                          const Icon(Icons.lock, color: Colors.black, size: 18),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 2),
                          borderRadius: BorderRadius.circular(10)),
                      floatingLabelStyle:
                          const TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                FadeInDown(
                  child: TextField(
                    controller: controller
                        .passwordConfirmationController, // Bind the password confirmation controller
                    obscureText: true,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 1.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Confirm Password",
                      hintText: "Re-enter your password",
                      hintStyle: const TextStyle(
                          color: Colors.lightBlue, fontSize: 14.0),
                      labelStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                      prefixIcon: const Icon(Icons.lock_outline,
                          color: Colors.black, size: 18),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 2),
                          borderRadius: BorderRadius.circular(10)),
                      floatingLabelStyle:
                          const TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                FadeInDown(
                  child: TextField(
                    controller: controller
                        .principalTenantIdController, // New Principal Tenant ID Controller
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 1.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Principal Tenant ID",
                      hintText: "Enter the Principal Tenant ID",
                      hintStyle: const TextStyle(
                          color: Colors.lightBlue, fontSize: 14.0),
                      labelStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                      prefixIcon: const Icon(Icons.person_pin,
                          color: Colors.black, size: 18),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 2),
                          borderRadius: BorderRadius.circular(10)),
                      floatingLabelStyle:
                          const TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                // New Property ID Field
                FadeInDown(
                  child: TextField(
                    controller: controller
                        .propertyIdController, // Bind the property ID controller
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 1.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Property ID",
                      hintText: "Enter your property ID",
                      hintStyle: const TextStyle(
                          color: Colors.lightBlue, fontSize: 14.0),
                      labelStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                      prefixIcon:
                          const Icon(Icons.home, color: Colors.black, size: 18),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 2),
                          borderRadius: BorderRadius.circular(10)),
                      floatingLabelStyle:
                          const TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(height: 30.0),
                FadeInDown(
                  child: MaterialButton(
                    onPressed: () => controller
                        .onRequestButtonClicked(), // Trigger the controller method
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    minWidth: double.infinity,
                    child: const Text("Send Request",
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(height: 20.0),
                FadeInDown(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Already a tenant?",
                          style: TextStyle(color: Colors.grey.shade700)),
                      TextButton(
                        onPressed: () {
                          Get.toNamed(
                              "/login"); // Change this to your login route
                        },
                        child: const Text("Login"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
