import 'package:buss/Utils/Constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../Models/Booking.dart';
import '../main.dart'; // Assuming Booking model is in a separate file

class BookingRecord extends StatelessWidget {
  final Booking booking;

  const BookingRecord({Key? key, required this.booking}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('yyyy-MM-dd HH:mm'); // Customize format here
    final formattedDepartureTime = formatter.format(booking.departureTime);
    final formattedArrivalTime = formatter.format(booking.arrivalTime);
    final formattedBookingTime = formatter.format(booking.bookingDate);

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
          bottomLeft: Radius.circular(10.0),
          bottomRight: Radius.circular(10.0),
        ),
        border: Border.all(
          color: Provider.of<ThemeProvider>(context).isDarkMode
              ? Colors.white
              : Colors.black, // Set border color to black
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                child: Image.network(
                  "$linkImageRoot/${booking.companyLogoUrl}",
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                booking.companyName,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Text('Number of Seats: ${booking.numberOfSeats}'),
          const SizedBox(height: 8.0),
          Text('From City: ${booking.fromCity}'),
          const SizedBox(height: 8.0),
          Text('To City: ${booking.toCity}'),
          const SizedBox(height: 8.0),
          Text('Departure Time: $formattedDepartureTime'),
          const SizedBox(height: 8.0),
          Text('Arrival Time: $formattedArrivalTime'),
          const SizedBox(height: 8.0),
          Text('Booking Date: $formattedBookingTime'),
        ],
      ),
    );
  }
}
