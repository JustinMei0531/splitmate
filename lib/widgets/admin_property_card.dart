import "package:flutter/material.dart";

class AdminPropertyCard extends StatelessWidget {
  final String propertyName;

  final int tenantCount;

  List<String> servicesList = [];

  final String propertyAddress;

  final String imagePath;

  final double rent;

  AdminPropertyCard(
      {required this.rent,
      required this.propertyName,
      required this.tenantCount,
      required this.servicesList,
      required this.propertyAddress,
      required this.imagePath,
      super.key});

  @override
  Widget build(BuildContext context) {
    double scHeight = MediaQuery.of(context).size.height;
    double scWidth = MediaQuery.of(context).size.width;
    return Column(
      children: <Widget>[
        InkWell(
            borderRadius: BorderRadius.circular(10.0),
            onTap: () {},
            child: Card(
                margin: const EdgeInsets.all(0.0),
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: scHeight * 0.8 / 5,
                      width: scHeight * 0.8 / 5,
                      color: Colors.grey.shade200,
                      child: const Text("Image cap"),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Container(
                      height: scHeight * 0.8 / 5,
                      width: scWidth - scHeight * 0.9 / 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            "$rent AUD/Week",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18.0),
                          ),
                          Text(
                            propertyAddress.length < 40
                                ? propertyAddress
                                : "${propertyAddress.substring(0, 37)}...",
                            style: const TextStyle(color: Colors.grey),
                            overflow: TextOverflow.clip,
                          ),
                          Row(
                            children: <Widget>[
                              const Icon(
                                Icons.people,
                                color: Colors.grey,
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Text("$tenantCount active tenants")
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            height: 25.0,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: servicesList.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) => Container(
                                margin: const EdgeInsets.fromLTRB(
                                    0.0, 0.0, 5.0, 0.0),
                                width: 60.0,
                                height: 25,
                                alignment: Alignment.center,
                                color: Colors.orange,
                                child: Text(
                                  servicesList[index],
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ))),
        const SizedBox(
          height: 10.0,
        )
      ],
    );
  }
}
