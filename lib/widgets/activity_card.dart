import "package:flutter/material.dart";

// Assume we have five fee types
enum ActivityType {
  RENT,
  WATER,
  ElECTRICITY,
  GAS,
}

// Assume we have three  types of activity status
enum ActivityStatus { COMPLETED, PENDING, FALLURE }

class ActivityCard extends StatelessWidget {
  final ActivityType type;

  final ActivityStatus status;

  final double payment;

  final String propertyName;

  final String date;

  ActivityCard(
      {required this.type,
      required this.status,
      required this.payment,
      required this.propertyName,
      required this.date,
      super.key});

  Icon getItemIcon() {
    Color iconColor = Colors.orange;
    double iconSize = 40.0;
    switch (type) {
      case ActivityType.RENT:
        return Icon(Icons.house, size: iconSize, color: iconColor);
      case ActivityType.ElECTRICITY:
        return Icon(Icons.power, size: iconSize, color: iconColor);
      case ActivityType.GAS:
        return Icon(Icons.gas_meter, size: iconSize, color: iconColor);
      case ActivityType.WATER:
        return Icon(Icons.water, size: iconSize, color: iconColor);
      default:
        return Icon(Icons.house, size: iconSize, color: iconColor);
    }
  }

  Color getLabelColor() {
    switch (status) {
      case ActivityStatus.COMPLETED:
        return const Color.fromRGBO(138, 230, 183, 1.0);
      case ActivityStatus.FALLURE:
        return Colors.red.shade300;
      case ActivityStatus.PENDING:
        return Colors.orange.shade300;
      default:
        return const Color.fromRGBO(138, 230, 183, 1.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(10.0),
            color: const Color.fromRGBO(242, 242, 242, 1.0),
            child: Row(
              children: <Widget>[
                Text(
                  date,
                  style: const TextStyle(
                      color: Color.fromRGBO(111, 206, 174, 1.0),
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Row(
                    children: [
                      Column(
                        children: <Widget>[
                          getItemIcon(),
                        ],
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            type.name.toUpperCase(),
                            textAlign: TextAlign.left,
                          ),
                          Text(propertyName, textAlign: TextAlign.left)
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("\$$payment"),
                    const Text(
                      "Payment",
                      style: TextStyle(
                          fontSize: 15.0,
                          color: Color.fromRGBO(184, 184, 184, 1.0)),
                    ),
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: getLabelColor(),
                          borderRadius: BorderRadius.circular(8.0)),
                      width: 70.0,
                      height: 25.0,
                      child: Text(
                        status.name.toUpperCase(),
                        style: const TextStyle(
                            fontSize: 10.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
