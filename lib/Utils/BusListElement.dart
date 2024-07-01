import 'package:buss/Models/BusInfo.dart';
import 'package:buss/Presentation/BusDetailedPage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'Constants.dart';

class BusListElement extends StatelessWidget {
  const BusListElement({
    super.key,
    required this.busInfo,
    required this.fromCity,
    required this.toCity,
  });

  final BusInfo busInfo;
  final String fromCity;
  final String toCity;

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('HH:mm a'); // Customize format here
    final formattedDepartureTime = formatter.format(busInfo.departureTime);
    final formattedArrivalTime = formatter.format(busInfo.arrivalTime);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BusDetailsPage(
              busInfo: busInfo,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(10.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2.0,
              blurRadius: 5.0,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListTile(
            leading: Row(
              mainAxisSize: MainAxisSize.min, // Avoid stretching icons
              children: [
                CircleAvatar(
                  child: Image.network(
                    "$linkImageRoot/${busInfo.companyLogo}",
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(width: 5.0),
                Text(
                  busInfo.companyName,
                  style: const TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            title: Column(
              children: [
                // const Text(
                //   'Departure: ',
                // ),
                Text(
                  "Dep: $formattedDepartureTime",
                ),
                // const Text(
                //   'Departure: ',
                // ),
                Text(
                  "Arr: $formattedArrivalTime",
                )
              ],
            ),
            trailing: Text(
              '${busInfo.price.toString()} EGP / Seat',
              style: const TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
