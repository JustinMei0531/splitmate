import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:splitmate/services/user_service.dart';
import 'package:flutter/material.dart';

class TenantsController extends GetxController {
  // Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Inject UserService to get the principal tenant ID
  final UserService userService = Get.find<UserService>();

  // Observable list to store tenant data
  final RxList<Map<String, dynamic>> tenantsList = <Map<String, dynamic>>[].obs;

  // Loading indicator
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    // Fetch tenants for the principal tenant when the controller is initialized
    fetchTenantsForPrincipalTenant();
  }

  // Fetch tenants for the principal tenant
  Future<void> fetchTenantsForPrincipalTenant() async {
    try {
      isLoading.value = true;

      // Get the principal tenant's `uid` from UserService
      String? principalTenantId = userService.userInfo?['uid'];

      debugPrint(principalTenantId);

      if (principalTenantId == null) {
        Get.snackbar("Error", "Principal tenant ID not found.");
        isLoading.value = false;
        return;
      }

      // Log to check if the principal tenant ID is correctly retrieved
      debugPrint('Principal Tenant ID: $principalTenantId');

      // Query the `users` collection where the `uid` matches the principal tenant ID
      DocumentSnapshot principalTenantDoc =
          await _firestore.collection('users').doc(principalTenantId).get();

      if (!principalTenantDoc.exists) {
        Get.snackbar("Error", "Principal tenant document not found.");
        isLoading.value = false;
        return;
      }

      // Retrieve the `tenant_list` field and log the tenant_list data
      List<dynamic> tenantUids = principalTenantDoc['tenant_list'] ?? [];
      debugPrint('Tenant UIDs: $tenantUids');

      if (tenantUids.isEmpty) {
        Get.snackbar("Info", "No tenants found for this principal tenant.");
        isLoading.value = false;
        return;
      }

      // Fetch each tenant's information using the tenant UIDs
      List<Map<String, dynamic>> tenantData = [];

      for (String tenantUid in tenantUids) {
        DocumentSnapshot tenantDoc =
            await _firestore.collection('users').doc(tenantUid).get();

        // Log to check each tenant's data
        debugPrint('Fetching data for tenant UID: $tenantUid');

        if (tenantDoc.exists) {
          tenantData.add({
            'name': tenantDoc['name'] ?? 'Unknown',
            'email': tenantDoc['email'] ?? 'No email',
            'avatar': tenantDoc['avatar_url'] ?? '',
          });

          debugPrint(
              'Tenant fetched: Name: ${tenantDoc['name']}, Email: ${tenantDoc['email']}');
        } else {
          debugPrint('Tenant document not found for UID: $tenantUid');
        }
      }

      // Update the tenantsList with the fetched data
      tenantsList.value = tenantData;
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch tenants: $e");
      debugPrint('Error fetching tenants: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
