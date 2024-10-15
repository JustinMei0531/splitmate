import "package:flutter/material.dart";
import "package:get/get.dart";

class PropertyDetailsPage extends StatelessWidget {
  PropertyDetailsPage({Key? key}) : super(key: key);

  final String propertyName = Get.arguments["propertyName"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(
          propertyName,
          style: const TextStyle(fontSize: 14.0),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Property Images & Title Section
            Card(
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    // Property Image
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: const DecorationImage(
                          image: NetworkImage(
                              'https://your-image-url.jpg'), // Replace with your image URL
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    // Property Details
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "0408c/203 North Terrace",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Adelaide, SA 5000",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    const Spacer(),
                    // Property Images CircleAvatars
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://property-logo-url.jpg'), // Replace with image URL
                    ),
                    const SizedBox(width: 8),
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://another-property-image.jpg'), // Replace with image URL
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Property Details Section
            Card(
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Property details",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: const [
                        Text(
                          "Property type: ",
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text("House"),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: const [
                        Text(
                          "You are the: ",
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text("Tenant"),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Attachments",
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: const DecorationImage(
                          image: NetworkImage(
                              'https://your-attachment-url.jpg'), // Replace with your attachment image URL
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Real Estate Agent Section
            Card(
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Real estate agent",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ListTile(
                      leading: CircleAvatar(
                        child: const Text("AB"),
                        backgroundColor: Colors.purple.shade200,
                      ),
                      title: const Text("Adelaide Booking"),
                      subtitle: const Text(
                        "adelaidecentral@switchliving.com.au",
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Phone: 1800 001 909",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Maintenance Request Section
            Card(
              elevation: 4.0,
              child: ListTile(
                leading: const Icon(Icons.build, color: Colors.orange),
                title: const Text("Maintenance request"),
                trailing: ElevatedButton(
                  onPressed: () {
                    // Add action for maintenance button
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                  child: const Text("Maintenance"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
