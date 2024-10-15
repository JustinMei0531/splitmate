import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:splitmate/services/user_service.dart';

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

      // Get the principal tenant's ID from UserService
      String? principalTenantId = userService.userInfo?['uid'];

      if (principalTenantId == null) {
        Get.snackbar("Error", "Principal tenant ID not found.");
        isLoading.value = false;
        return;
      }

      // Fetch the principal tenant's document to get the tenant_list
      DocumentSnapshot principalTenantDoc =
          await _firestore.collection('users').doc(principalTenantId).get();

      if (!principalTenantDoc.exists) {
        Get.snackbar("Error", "Principal tenant document not found.");
        isLoading.value = false;
        return;
      }

      // Retrieve the tenant_list field
      List<dynamic> tenantUids = principalTenantDoc['tenant_list'] ?? [];

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

        if (tenantDoc.exists) {
          tenantData.add({
            'name': tenantDoc['name'] ?? 'Unknown',
            'email': tenantDoc['email'] ?? 'No email',
            'avatar': tenantDoc['avatar_url'] ?? '',
          });
        }
      }

      // Update the tenantsList with the fetched data
      tenantsList.value = tenantData;
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch tenants: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
