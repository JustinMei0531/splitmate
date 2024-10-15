import "package:flutter/material.dart";
import "package:get/get.dart";
import "../widgets/circular_progress.dart";

class ActiveServiceCard extends StatelessWidget {
  final String title;
  final String amount;
  final int daysRemaining;
  final double progress;

  ActiveServiceCard(
      {required this.title,
      required this.amount,
      required this.daysRemaining,
      required this.progress,
      super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed("/user-activity-detail");
      },
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.grey, width: 1.0),
          ),
          width: 130.0,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(color: Colors.grey, fontSize: 12.0),
                ),
                SizedBox(
                  height: 2.0,
                ),
                Text(
                  "Total:\n$amount",
                  style: TextStyle(color: Colors.black, fontSize: 16.0),
                ),
                SizedBox(height: 5.0),
                CircularProgress(
                    progress: progress, label: "$daysRemaining\ndays")
              ],
            ),
          )),
    );
  }
}
