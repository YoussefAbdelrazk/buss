import 'package:buss/Presentation/BookingPage.dart';
import 'package:buss/main.dart';
import 'package:flutter/material.dart';

import '../Models/BusInfo.dart';

class SeatBooking extends StatefulWidget {
  final BusInfo busInfo;

  const SeatBooking({
    super.key,
    required this.busInfo,
  });

  @override
  State<SeatBooking> createState() => _SeatBookingState();
}

class _SeatBookingState extends State<SeatBooking> {
  var countSeat = 50; // Total number of seats
  var listSeat = [];
  List<int> SelectedSeatList = [];

  @override
  void initState() {
    super.initState();
    initSeatValueTolist(listSeat, countSeat);

    // Reset isSelected flag for all seats on page initialization
    for (var seat in listSeat) {
      seat["isSelected"] = false;
    }
  }

  initSeatValueTolist(List data, count) {
    Map<String, dynamic> objectData;
    for (int i = 0; i < count; i++) {
      objectData = {
        "id": "${i + 1}",
        "isBooked":
            i < 2 || i % 3 == 0 ? true : false, // Set first two seats as booked
        "isAvailable": true,
        "isSelected": false,
        "isVisible": true,
      };
      setState(() {
        data.add(objectData);
      });
    }
  }

  setSelectedToBooked() {
    List<int> tempList = [];
    for (var seat in listSeat) {
      if (seat["isSelected"]) {
        setState(() {
          seat["isBooked"] = true;
          tempList.add(int.parse(seat["id"]));
        });
      }
    }

    SelectedSeatList = tempList;
    if (SelectedSeatList.length ==
        int.parse(sharedPref.getInt('numberOfPeople').toString())) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BookingPage(
            SelectedSeats: SelectedSeatList,
            busInfo: widget.busInfo,
            totalSeats: int.parse(
              sharedPref.getInt('numberOfPeople').toString(),
            ),
          ),
        ),
      );
      print(SelectedSeatList.length);
      print(sharedPref.getInt('numberOfPeople').toString());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please Select The Required Seats.'),
          action: SnackBarAction(label: 'Okay', onPressed: () {}),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Your seat'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      child: Row(
                        children: [
                          Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text('Available'),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Row(
                        children: [
                          Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.green,
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text('Selected'),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Row(
                        children: [
                          Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.red,
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text('Booked'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              WidgetSeat(listSeat),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {
                  setSelectedToBooked();
                },
                child: const Text("Book Seats"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget WidgetSeat(List dataSeat) {
    return SizedBox(
      width: MediaQuery.of(context).size.width, // Use full screen width
      child: Column(
        children: [
          for (int i = 0;
              i < (dataSeat.length / 5).ceil();
              i++) // Loop through rows
            buildRow(dataSeat, i), // Build a row of seats
        ],
      ),
    );
  }

  Widget buildRow(List dataSeat, int rowIndex) {
    final bool isLastRow =
        rowIndex == (dataSeat.length / 5).ceil() - 1; // Check for last row

    if (isLastRow) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribute evenly
        children: [
          for (int i = rowIndex * 5;
              i < dataSeat.length;
              i++) // Loop for seats in last row
            buildSeat(dataSeat, i),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribute evenly
        children: [
          buildSeatPair(dataSeat, rowIndex * 4), // First seat pair
          // Add space between seat pairs
          buildSeatPair(
              dataSeat, rowIndex * 4 + 2), // Second seat pair (if available)
        ],
      );
    }
  }

  Widget buildSeatPair(List dataSeat, int index) {
    return Row(
      children: [
        buildSeat(dataSeat, index), // First seat
        buildSeat(dataSeat, index + 1), // Second seat (if available)
      ],
    );
  }

  Widget buildSeat(List dataSeat, int index) {
    if (index >= dataSeat.length) {
      return const SizedBox(); // Handle out-of-bounds
    }

    return Visibility(
      visible: dataSeat[index]["isVisible"],
      child: GestureDetector(
        onTap: () {
          setState(() {
            // Set isSelected to false if already selected (for deselection)
            if (dataSeat[index]["isSelected"]) {
              dataSeat[index]["isSelected"] = false;
            } else {
              dataSeat[index]["isSelected"] = true;
            }
          });
          setState(() {
            // Set isSelected to false if already selected (for deselection)
            if (dataSeat[index]["isBooked"]) {
              dataSeat[index]["isBooked"] = false;
              dataSeat[index]["isSelected"] = false;
            } else {}
          });
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 2.5, vertical: 5),
          width: (MediaQuery.of(context).size.width - 60) /
              5, // Adjust seat width for 5 seats
          height: 50, // Adjust seat height (optional)
          decoration: BoxDecoration(
            color: dataSeat[index]["isBooked"]
                ? Colors.red
                : dataSeat[index]["isSelected"]
                    ? Colors.green
                    : Colors.grey,
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              (index + 1).toString(),
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  // Widget buildSeat(List dataSeat, int index) {
  //   if (index >= dataSeat.length) {
  //     return const SizedBox(); // Handle out-of-bounds
  //   }

  //   return GestureDetector(
  //     onTap: () => _handleSeatTap(dataSeat, index), // Delegate tap handling
  //     child: Container(
  //       margin: const EdgeInsets.symmetric(horizontal: 2.5, vertical: 5),
  //       width: (MediaQuery.of(context).size.width - 60) /
  //           5, // Adjust seat width for 5 seats
  //       height: 50, // Adjust seat height (optional)
  //       decoration: BoxDecoration(
  //         color: dataSeat[index]["isBooked"]
  //             ? Colors.red
  //             : dataSeat[index]["isSelected"]
  //                 ? Colors.green
  //                 : Colors.grey,
  //         border: Border.all(color: Colors.black),
  //         borderRadius: BorderRadius.circular(10),
  //       ),
  //       child: Center(
  //         child: Text(
  //           (index + 1).toString(),
  //           style: const TextStyle(
  //               color: Colors.white, fontWeight: FontWeight.bold),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // void _handleSeatTap(List dataSeat, int index) {
  //   // Only allow selection if not already booked
  //   if (!dataSeat[index]["isBooked"]) {
  //     setState(() {
  //       // Toggle isSelected for selection/deselection
  //       dataSeat[index]["isSelected"] = !dataSeat[index]["isSelected"];
  //     });
  //   }
  // }
}
