import "package:flutter/material.dart";
import "service_item.dart";

class RegularServicesGrid extends StatelessWidget {
  const RegularServicesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 4,
      shrinkWrap: true,
      crossAxisSpacing: 10.0,
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        ServiceItem(icon: Icons.fitness_center, label: "Fitness studio"),
        ServiceItem(icon: Icons.meeting_room, label: "Book spaces"),
        ServiceItem(icon: Icons.vpn_key, label: "Digital key"),
        ServiceItem(icon: Icons.favorite, label: "Wellbeing"),
      ],
    );
  }
}
