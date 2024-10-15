import 'package:flutter/material.dart';
import 'package:splitmate/widgets/active_service_list.dart';
import 'package:splitmate/widgets/news_section.dart';
import 'package:splitmate/widgets/quick_links.dart';
import '../widgets/section_title.dart';
import '../widgets/user_property_card.dart';
import '../widgets/regular_services_grid.dart';

class DashboardPage extends StatelessWidget {
  final services = [
    {"title": "Rent", "amount": "\$698pf", "daysRemaining": 5, "progress": 0.7},
    {"title": "Water", "amount": "\$50pf", "daysRemaining": 3, "progress": 0.5},
    {
      "title": "Appliance",
      "amount": "\$100pf",
      "daysRemaining": 7,
      "progress": 0.9
    },
    {
      "title": "Car Park",
      "amount": "\$666pf",
      "daysRemaining": 66,
      "progress": 0.5
    },
    // Add more services as needed
  ];
  DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: "Property"),
          const SizedBox(height: 10),
          const UserPropertyCard(),
          const SizedBox(height: 20),
          const SectionTitle(title: "Active services"),
          const SizedBox(height: 10),
          ActiveServiceList(services: services),
          const SizedBox(height: 20),
          const SectionTitle(title: "Regular services"),
          const SizedBox(height: 10),
          const RegularServicesGrid(),
          const SizedBox(height: 20),
          const SectionTitle(title: "Booking requests & maintenance"),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            children: <Widget>[
              InkWell(
                onTap: () {},
                child: Container(
                    padding: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                        // color: Colors.grey.shade100,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.0)),
                    width: MediaQuery.of(context).size.width / 2.5,
                    height: 110.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Icon(Icons.search),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "Raise request",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Request a fix",
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    )),
              ),
            ],
          ),
          const QuickLinks(),
          const SizedBox(height: 20),
          const NewsSection()
        ],
      ),
    );
  }
}
