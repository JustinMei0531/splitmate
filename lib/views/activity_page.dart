import "package:flutter/material.dart";
import "package:splitmate/widgets/activity_card.dart";

class ActivityPage extends StatelessWidget {
  ActivityPage({super.key});

  final List<Map<String, dynamic>> fakeData = [
    {
      "service_type": 1,
      "status": 1,
      "payment": 1500.0,
      "property_name": "Greenfield Heights",
      "date": "10, MARCH, 2019"
    },
    {
      "service_type": 0,
      "status": 0,
      "payment": 3200.0,
      "property_name": "Skyline Tower",
      "date": "22, AUGUST, 2020"
    },
    {
      "service_type": 2,
      "status": 1,
      "payment": 2800.0,
      "property_name": "Blue Horizon",
      "date": "05, JANUARY, 2021"
    },
    {
      "service_type": 3,
      "status": 0,
      "payment": 1800.0,
      "property_name": "Oceanview Apartments",
      "date": "16, MAY, 2022"
    },
    {
      "service_type": 1,
      "status": 1,
      "payment": 2500.0,
      "property_name": "Sunset Villa",
      "date": "30, JULY, 2023"
    },
    {
      "service_type": 1,
      "status": 1,
      "payment": 2500.0,
      "property_name": "Sunset Villa",
      "date": "30, JULY, 2023"
    },
    {
      "service_type": 1,
      "status": 1,
      "payment": 2500.0,
      "property_name": "Sunset Villa",
      "date": "30, JULY, 2023"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                width: double.infinity,
                height: 35.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    SizedBox(
                      height: 30.0,
                      child: ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.orange)),
                        onPressed: () {},
                        child: const Text(
                          "All date",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    SizedBox(
                      height: 30.0,
                      child: ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.orange)),
                        onPressed: () {},
                        child: const Text(
                          "Upcoming",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    SizedBox(
                      height: 30.0,
                      child: ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.orange)),
                        onPressed: () {},
                        child: const Text(
                          "Last month",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    SizedBox(
                      height: 30.0,
                      child: ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.orange)),
                        onPressed: () {},
                        child: const Text(
                          "Last year",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Container(
            width: double.infinity,
            height: 10.0,
            color: const Color.fromRGBO(242, 242, 242, 1.0),
          ),
          Container(
              height: 100.0,
              width: double.infinity,
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "\$12345.00",
                    style:
                        TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
                  ),
                  Text("(Since 12th Dec 2022)")
                ],
              )),
          ListView.builder(
            itemCount: fakeData.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => ActivityCard(
                type: ActivityType.values[fakeData[index]["service_type"]],
                status: ActivityStatus.values[fakeData[index]["status"]],
                payment: fakeData[index]["payment"],
                propertyName: fakeData[index]["property_name"],
                date: fakeData[index]["date"]),
          ),
          // Container(
          //   width: double.infinity,
          //   height: 10.0,
          //   color: const Color.fromRGBO(242, 242, 242, 1.0),
          // ),
        ],
      ),
    );
  }
}
