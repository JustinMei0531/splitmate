import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:splitmate/controllers/tenants_controller.dart';

class AllTenantsPage extends StatelessWidget {
  AllTenantsPage({super.key});

  // Initialize the TenantsController
  final TenantsController tenantsController = Get.put(TenantsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        // Show loading indicator while data is being fetched
        if (tenantsController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // Check if no tenants are available
        if (tenantsController.tenantsList.isEmpty) {
          return const Center(child: Text("No tenants found"));
        }

        // Display the list of tenants
        return ListView.builder(
          itemCount: tenantsController.tenantsList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            var tenant = tenantsController.tenantsList[index];
            return InkWell(
              onTap: () {
                // Handle tap if needed
              },
              child: ListTile(
                contentPadding: const EdgeInsets.all(10.0),
                leading: CircleAvatar(
                  backgroundImage: tenant['avatar'].isNotEmpty
                      ? NetworkImage(tenant['avatar'])
                      : null,
                  child: tenant['avatar'].isEmpty
                      ? Text(
                          tenant['name'][0]
                              .toUpperCase(), // Use initials if no avatar
                          style: const TextStyle(color: Colors.white),
                        )
                      : null,
                  radius: 30.0,
                ),
                title: Text(
                  tenant['name'],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text("Email: ${tenant['email']}"),
              ),
            );
          },
        );
      }),
    );
  }
}
