import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:splitmate/services/user_service.dart';

class ApplyController extends GetxController {
  // Controllers for input fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmationController =
      TextEditingController();
  final TextEditingController propertyIdController =
      TextEditingController(); // Add property ID controller
  final TextEditingController principalTenantIdController =
      TextEditingController(); // Add principal tenant ID controller

  // Firebase instances
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Loading state
  final RxBool isLoading = false.obs;

  // Register a new user and update the property document
  void onRequestButtonClicked() async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String passwordConfirmation = passwordConfirmationController.text.trim();
    String propertyId = propertyIdController.text.trim();
    String principalTenantId = principalTenantIdController.text.trim();

    // Validate all fields
    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        passwordConfirmation.isEmpty ||
        propertyId.isEmpty ||
        principalTenantId.isEmpty) {
      showErrorSnackbar("Please complete all the required fields.");
      return;
    }

    // Check if passwords match
    if (password != passwordConfirmation) {
      showErrorSnackbar("Passwords do not match.");
      return;
    }

    // Check if the email already exists in Firestore
    bool emailExists = await checkEmailExists(email);
    if (emailExists) {
      showErrorSnackbar("The email address is already in use.");
      return;
    }

    // Start loading
    isLoading.value = true;

    try {
      // Check if the property exists in Firestore
      DocumentSnapshot propertyDoc =
          await _firestore.collection('properties').doc(propertyId).get();

      if (!propertyDoc.exists) {
        showErrorSnackbar("The property ID is not valid.");
        isLoading.value = false;
        return;
      }

      // Create a new user in Firebase Auth
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        String userId = userCredential.user!.uid;

        // Add user data to Firestore users collection
        await _firestore.collection('users').doc(userId).set({
          'uid': userId,
          'name': name,
          'email': email,
          'role': 0, // Role 0 for tenants
          'avatar_url': '',
          'property_id': propertyId,
          'createdAt': FieldValue.serverTimestamp(),
          'first_login': true, // Mark as first login
        });

        // Increment tenants count in the property document
        await _firestore.runTransaction((transaction) async {
          DocumentSnapshot freshSnap =
              await transaction.get(propertyDoc.reference);
          int currentTenantsCount = freshSnap['tenants_count'] ?? 0;

          // Increment tenants count
          transaction.update(freshSnap.reference, {
            'tenants_count': currentTenantsCount + 1,
          });
        });

        // Link the new user to the principal tenant's tenant list
        await updatePrincipalTenantList(principalTenantId, userId);

        // Show success message
        Get.snackbar(
          "Success",
          "Registration completed successfully.",
          icon: const Padding(
            padding: EdgeInsets.all(10.0),
            child: Icon(Icons.check_circle, color: Colors.green, size: 30.0),
          ),
          padding: const EdgeInsets.all(15.0),
        );

        // Redirect to the login page
        Get.offNamed("login");
      }
    } catch (e) {
      showErrorSnackbar("Registration failed: $e");
    } finally {
      isLoading.value = false; // Stop loading
    }
  }

  // Function to check if an email already exists in the Firestore users collection
  Future<bool> checkEmailExists(String email) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    return querySnapshot.docs.isNotEmpty;
  }

  // Function to update the principal tenant's tenant list
  Future<void> updatePrincipalTenantList(
      String principalTenantId, String newTenantId) async {
    DocumentSnapshot principalTenantDoc =
        await _firestore.collection('users').doc(principalTenantId).get();

    if (principalTenantDoc.exists) {
      List<dynamic> tenantList = principalTenantDoc['tenant_list'] ?? [];
      tenantList.add(newTenantId);

      // Update the principal tenant's tenant list
      await _firestore
          .collection('users')
          .doc(principalTenantId)
          .update({'tenant_list': tenantList});
    } else {
      showErrorSnackbar("Principal tenant not found.");
    }
  }

  // Show error snackbar
  void showErrorSnackbar(String message) {
    Get.snackbar(
      "Error",
      message,
      icon: const Padding(
        padding: EdgeInsets.all(10.0),
        child: Icon(Icons.error, color: Colors.red, size: 30.0),
      ),
      padding: const EdgeInsets.all(15.0),
    );
  }
}
