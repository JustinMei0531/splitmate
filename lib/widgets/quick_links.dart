import "package:flutter/material.dart";

class QuickLinks extends StatelessWidget {
  const QuickLinks({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            'Quick links',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        InkWell(
          onTap: () {
            // Handle navigation to New maintenance request page
          },
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'New maintenance request',
                  style: TextStyle(fontSize: 16.0),
                ),
                Icon(Icons.arrow_forward_ios, size: 16.0),
              ],
            ),
          ),
        ),
        const Divider(),
        InkWell(
          onTap: () {},
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Say hello to our team',
                  style: TextStyle(fontSize: 16.0),
                ),
                Icon(Icons.arrow_forward_ios, size: 16.0)
              ],
            ),
          ),
        ),
        const Divider()
      ],
    );
  }
}
