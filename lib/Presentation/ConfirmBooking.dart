import 'package:buss/Models/BusInfo.dart';
import 'package:buss/Database%20Repo/PDFInvoice.dart';
import 'package:buss/Presentation/HomePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../main.dart';

class ConfirmationPage extends StatelessWidget {
  final BusInfo busInfo;
  final int totalSeats;
  final String passengerName;
  final String passengerPhone;

  const ConfirmationPage({
    Key? key,
    required this.busInfo,
    required this.totalSeats,
    required this.passengerName,
    required this.passengerPhone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final num totalPrice = totalSeats * busInfo.price;
    final formatter = DateFormat('yyyy-MM-dd HH:mm'); // Customize format here
    final formattedDepartureTime = formatter.format(busInfo.departureTime);
    final formattedArrivalTime = formatter.format(busInfo.arrivalTime);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Confirmed'),
      ),
      body: SingleChildScrollView(
        // Allow scrolling if content overflows
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Left-align content
          children: [
            Center(child: Image.asset('assets/ConfirmedPayment.jpg')),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Bus Information:',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      '${busInfo.companyName} ',
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      '${busInfo.origin} ',
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      '${busInfo.destination} ',
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                        'Time: $formattedDepartureTime to $formattedArrivalTime'),
                    const SizedBox(height: 10.0),
                    Text('Total Seats: $totalSeats seats'),
                    const SizedBox(height: 10.0),
                    Text('Total Price:  $totalPrice EGP'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Passenger Information:',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10.0),
                    Text('Name: $passengerName'),
                    const SizedBox(height: 10.0),
                    Text('Phone Number: $passengerPhone'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Center(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () => PdfInvoice.generate(
                      // Call the static method from PdfInvoice
                      busInfo,
                      totalSeats,
                      passengerName,
                      passengerPhone,
                      'C:/Users/ziada/Desktop',
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Text('Print Ticket'),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => HomePage(
                                userName: sharedPref.getString('username')!,
                                password: sharedPref.getString('password')!),
                          )
                          // Go back to the home screen (replace based on your navigation setup)
                          );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Text('Go Back Home'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
