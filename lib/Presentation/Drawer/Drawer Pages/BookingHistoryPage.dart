import 'package:buss/Utils/Constants.dart';
import 'package:flutter/material.dart';
import '../../../Database Repo/Crud.dart';
import '../../../Models/Booking.dart';
import '../../../Utils/BookingHistoryWidget.dart';

class BookingHistoryPage extends StatefulWidget {
  final id;

  const BookingHistoryPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<BookingHistoryPage> createState() => _BookingHistoryPageState();
}

class _BookingHistoryPageState extends State<BookingHistoryPage> {
  Crud crud = Crud();

  Future<List<Booking>> getBookings() async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate delay

    var response = await crud.PostRequest(linkGetBookings, {
      "user_id": widget.id.toString(),
    });

    if (response['status'] == "success") {
      // Parse the 'data' list into a List<Booking>
      final bookings = (response['data'] as List)
          .map((bookingJson) => Booking.fromJson(bookingJson))
          .toList();
      for (var booking in bookings) {
        print(booking.busInfoId);
      }
      return bookings;
    } else {
      throw Exception('API call failed'); // Or a more specific exception type
    }
  }

  // ... Your page state and logic (if needed)
  @override
  Widget build(BuildContext context) {
    // Assuming you have a list of bookings (replace with your logic)

    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking History'),
      ),
      body: FutureBuilder<List<Booking>>(
        future: getBookings(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final bookings = snapshot.data!;
            return ListView.separated(
              itemCount: snapshot.data!.length,
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  height: 20,
                );
              },
              itemBuilder: (BuildContext context, int index) {
                final booking = bookings[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BookingRecord(booking: booking),
                );
              },
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.black,
            ));
          } else {
            return const Center(
              child: Text('No bus information found.'),
            ); // No data found message
          }
        },
      ),
    );
  }
}
