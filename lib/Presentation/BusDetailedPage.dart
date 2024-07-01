import 'package:buss/Models/BusInfo.dart';
import 'package:buss/Presentation/BookingPage.dart';
import 'package:buss/Presentation/SeatBooking.dart';
import 'package:buss/main.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Utils/Constants.dart';

class BusDetailsPage extends StatelessWidget {
  final BusInfo busInfo;
  final List<String> availableFeatures = [
    "WiFi",
    "Port",
    "Meal",
    "small tv",
    "earpods",
    "water bottle"
  ];

  BusDetailsPage({Key? key, required this.busInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('yyyy-MM-dd HH:mm'); // Customize format here
    final formattedDepartureTime = formatter.format(busInfo.departureTime);
    final formattedArrivalTime = formatter.format(busInfo.arrivalTime);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bus Details'),
      ),
      body: SingleChildScrollView(
        // Allow scrolling for long content
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/Cover.jpg'),
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  child: Image.network(
                    "$linkImageRoot/${busInfo.companyLogo}",
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  busInfo.companyName.toString(),
                  style: const TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  busInfo.destination,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                const Icon(Icons.arrow_forward_ios),
                Text(
                  busInfo.origin,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ],
            ),

            Text('Available Seats: ${busInfo.availableSeats.toString()}'),
            Row(
              children: [
                const Text('Departure Time:'),
                const SizedBox(width: 5.0),
                Text(formattedDepartureTime),
              ],
            ),
            Row(
              children: [
                const Text('Arrival Time:'),
                const SizedBox(width: 5.0),
                Text(formattedArrivalTime),
              ],
            ),
            Row(
              children: [
                const Text('Price:'),
                const SizedBox(width: 5.0),
                Text(' ${busInfo.price.toString()} EGP'),
              ],
            ),
            const SizedBox(height: 15.0), // Add spacing between sections
            const Text(
              'Features & Amenities:',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 15,
            ),
            Wrap(
              // Use Wrap for horizontal arrangement
              spacing: 10.0, // Add spacing between features
              runSpacing: 10.0, // Add spacing between rows
              children: getFeatureChips(availableFeatures.take(5)),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod risus eu magna suscipit blandit. Pellentesque elementum libero vitae urna molestie, nec tempor mauris pretium. Cras justo odio, dapibus ac facilisis in, egestas eget quam.', // Replace with actual features
            ),
            // Add a divider (optional)
            const Divider(thickness: 1.0),
            const SizedBox(height: 10.0),
            // Seat map section (optional, implement if offering seat selection)

            const Text(
              'Cancellation & Baggage Allowance:',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5.0),
            const Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod risus eu magna suscipit blandit. Pellentesque elementum libero vitae urna molestie, nec tempor mauris pretium. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Maecenas sed diam eget risus varius blandit sit amet non magna.', // Replace with actual policies
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // Implement functionality to proceed with booking (optional)
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SeatBooking(
                              busInfo: busInfo,
                            ),
                          ),
                        );
                        print('Book Bus: ${busInfo.companyName}');
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: const Text('Pick Seats '),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFeatureChip(String feature) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      decoration: const ShapeDecoration(
          shape: StadiumBorder(), color: Color.fromRGBO(123, 150, 250, 1)),
      child: Text(
        feature,
        style: const TextStyle(fontSize: 12.0, color: Colors.white),
      ),
    );
  }

  List<Widget> getFeatureChips(Iterable<String> features) {
    return features.map((feature) => buildFeatureChip(feature)).toList();
  }
}
