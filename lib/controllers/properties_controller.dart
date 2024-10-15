import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class PropertiesController extends GetxController {
  // Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Observable list to store property data
  final RxList<Map<String, dynamic>> propertiesList =
      <Map<String, dynamic>>[].obs;

  // Loading indicator
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    // Fetch property data when the controller is initialized
    fetchProperties();
  }

  // Fetch properties from Firestore
  Future<void> fetchProperties() async {
    try {
      isLoading.value = true;

      // Get all documents from 'properties' collection
      QuerySnapshot querySnapshot =
          await _firestore.collection('properties').get();

      // Map Firestore documents to a list of property maps
      propertiesList.value = querySnapshot.docs.map((doc) {
        // Properly cast the `rent` field to double
        double rentValue =
            doc['rent'] is int ? (doc['rent'] as int).toDouble() : doc['rent'];

        return {
          'rent': rentValue, // Cast rent to double
          'propertyName': doc['property_name'],
          'tenantCount': doc['tenants_count'],
          'servicesList':
              List<String>.from(doc['services']), // Cast to a list of strings
          'propertyAddress': doc['address'],
          'imagePath': doc[
              'property_image_url'], // Assuming the image path is stored in Firestore
        };
      }).toList();
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch properties: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
