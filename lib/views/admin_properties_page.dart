import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:splitmate/widgets/admin_property_card.dart';
import 'package:splitmate/controllers/properties_controller.dart'; // Import the PropertiesController

class AdminPropertiesPage extends StatelessWidget {
  AdminPropertiesPage({super.key});

  // Initialize the PropertiesController
  final PropertiesController propertiesController =
      Get.put(PropertiesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        // Show loading indicator while data is being fetched
        if (propertiesController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // Check if no properties are available
        if (propertiesController.propertiesList.isEmpty) {
          return const Center(child: Text("No properties found"));
        }

        // Display the list of properties
        return ListView.builder(
          itemCount: propertiesController.propertiesList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            var property = propertiesController.propertiesList[index];
            return AdminPropertyCard(
              rent: property['rent'],
              propertyName: property['propertyName'],
              tenantCount: property['tenantCount'],
              servicesList: property['servicesList'],
              propertyAddress: property['propertyAddress'],
              imagePath: property['imagePath'],
              propertyType: property["propertyType"],
            );
          },
        );
      }),
    );
  }
}
