import "package:flutter/material.dart";

class UserPropertyCard extends StatelessWidget {
  const UserPropertyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: const Text("Property Name"),
        subtitle: const Text("Property Address"),
        trailing: SizedBox(
          width: 50,
          child: Row(
            children: const [
              CircleAvatar(
                backgroundColor: Colors.grey,
                child: Text("UN"),
                radius: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
