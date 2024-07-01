import 'package:buss/Models/BusInfo.dart';
import 'package:buss/Utils/BusListElement.dart';
import 'package:buss/Utils/Constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Database Repo/Crud.dart';

class BusResultsPage extends StatefulWidget {
  final String fromCity;
  final String toCity;
  final DateTime travelDate;
  final int numberOfPeople;

  const BusResultsPage({
    Key? key,
    required this.fromCity,
    required this.toCity,
    required this.travelDate,
    required this.numberOfPeople,
  }) : super(key: key);

  @override
  State<BusResultsPage> createState() => _BusResultsPageState();
}

class _BusResultsPageState extends State<BusResultsPage> {
  Crud crud = Crud();

  Future<List<dynamic>> getBusInfo() async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate delay

    // Format the travel date to YYYY-MM-DD string
    String formattedDate = widget.travelDate
        .toString()
        .split(' ')[0]; // Assuming 'YYYY-MM-DD' format

    var response = await crud.PostRequest(linkBusInfoName, {
      "origin": widget.fromCity,
      "destination": widget.toCity,
      "availableSeats": widget.numberOfPeople.toString(),
      "date": formattedDate.toString(), // Add the date parameter
    });

    if (response['status'] == "success") {
      return response['data'] as List<dynamic>;
    } else {
      throw Exception('API call failed'); // Or a more specific exception type
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bus Results'),
      ),
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              'assets/bus1.jpeg',
              fit: BoxFit.cover,
            ),
          ),
          // Optionally add a header with trip details
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.location_pin),
                        const SizedBox(
                          width: 3,
                        ),
                        Text(
                          widget.fromCity,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontSize: 20),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.white,
                          child: Image.asset(
                            'assets/Icons/Bus.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward,
                          size: 25,
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Row(
                      children: [
                        const Icon(Icons.location_pin),
                        const SizedBox(
                          width: 3,
                        ),
                        Text(
                          widget.toCity,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontSize: 20),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                // Add spacer for better spacing
                Text(
                  'Number of passengers: ${widget.numberOfPeople}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 15),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  'Date: ${DateFormat('EEEE, dd-MM-yyyy').format(widget.travelDate)}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 15),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: FutureBuilder(
              future: getBusInfo(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.separated(
                    itemCount: snapshot.data!.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider(
                        height: 20,
                      );
                    },
                    itemBuilder: (BuildContext context, int index) {
                      var businfoid = snapshot.data?[index]['id'];
                      var companyName = snapshot.data?[index]['name'];
                      var price = double.parse(snapshot.data?[index]['fare']);
                      var origin = snapshot.data?[index]['origin'];
                      var destination = snapshot.data?[index]['destination'];
                      var departureTime = DateTime.parse(
                          snapshot.data?[index]['departure_time']);

                      var arrivalTime =
                          DateTime.parse(snapshot.data?[index]['arrival_time']);
                      var availableSeat =
                          snapshot.data?[index]['available_seats'];
                      var companyLogo = snapshot.data?[index]['logo_url'];
                      return BusListElement(
                          busInfo: BusInfo(
                              businfoid: businfoid,
                              companyName: companyName,
                              companyLogo: companyLogo,
                              origin: origin,
                              destination: destination,
                              departureTime: departureTime,
                              arrivalTime: arrivalTime,
                              availableSeats: availableSeat,
                              price: price),
                          fromCity: widget.fromCity,
                          toCity: widget.toCity);
                      // Column(
                      //   children: [
                      //     Text(companyName),
                      //     Text(price),
                      //     Text(origin),
                      //     Text(destination),
                      //     Text(departureTime.toString()),
                      //     Text(arrivalTime.toString()),
                      //     Text(availableSeat.toString()),
                      //   ],
                      // );
                    },
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return const Center(
                    child: Text('No bus information found.'),
                  ); // No data found message
                }
              },
            ),

            // ListView.builder(
            //   itemCount: availableBuses.length,
            //   itemBuilder: (context, index) {
            //     final busInfo = availableBuses[index];
            //     return BusListElement(
            //       busInfo: busInfo,
            //       fromCity: fromCity,
            //       toCity: toCity,
            //     );
            //   },
            // ),
          ),
        ],
      ),
    );
  }
}
