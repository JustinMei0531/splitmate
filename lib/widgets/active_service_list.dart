import "package:flutter/material.dart";
import "package:splitmate/widgets/active_service_card.dart";

class ActiveServiceList extends StatelessWidget {
  List<Map<String, dynamic>> services;

  ActiveServiceList({required this.services, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.0,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: services.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: ActiveServiceCard(
              title: services[index]["title"],
              amount: services[index]["amount"],
              daysRemaining: services[index]["daysRemaining"],
              progress: services[index]["progress"],
            ),
          );
        },
      ),
    );
  }
}
