// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:buss/Presentation/LoginPage.dart';
import 'package:buss/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:buss/Presentation/BusResultPage.dart';
import 'package:buss/Utils/Constants.dart';
import 'package:buss/Utils/CustomNumberStepper.dart';
import 'package:provider/provider.dart';
import '../Database Repo/Crud.dart';
import 'Drawer/Drawer.dart';

class HomePage extends StatefulWidget {
  final String userName;
  final String password;
  const HomePage({
    Key? key,
    required this.userName,
    required this.password,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String fromCity = "";
  String toCity = "";
  DateTime selectedDate = DateTime.now();
  int numberOfPeople = 1; // Default to 1 person
  String? selectedFromCity; // Store the selected fromCity dropdown value
  String? selectedToCity; // Store the selected toCity dropdown value

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2025, 12, 31),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _swapCities() {
    // Swap selected city values
    final tempCity = selectedFromCity;
    selectedFromCity = selectedToCity;
    selectedToCity = tempCity;
    setState(() {});
  }

  void _navigateToSearchResults() {
    // Basic validation
    if (selectedFromCity == null || selectedToCity == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select both origin and destination cities'),
        ),
      );
      return;
    }
    sharedPref.setInt('numberOfPeople', numberOfPeople);
    // Navigate to SearchResultsPage with user input
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BusResultsPage(
          fromCity: selectedFromCity!,
          toCity: selectedToCity!,
          travelDate: selectedDate,
          numberOfPeople: numberOfPeople,
        ),
      ),
    );
  }

  Crud crud = Crud();

  // Future<List<Booking>> getBookings() async {
  //   await Future.delayed(const Duration(seconds: 2)); // Simulate delay

  //   var response = await crud.PostRequest(
  //     linkGetBookings,
  //     {
  //       "user_id": sharedPref.getString('id'),
  //     },
  //   );

  //   if (response['status'] == "success") {
  //     sharedPref.setInt(
  //         'numberofbookings', response['num']['numberofbookings']);

  //     // Parse the 'data' list into a List<Booking>
  //     final bookings = (response['data'] as List)
  //         .map(
  //           (bookingJson) => Booking.fromJson(bookingJson),
  //         )
  //         .toList();

  //     return bookings;
  //   } else {
  //     throw Exception('API call failed'); // Or a more specific exception type
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   leading: Builder(
      //     builder: (context) => IconButton(
      //       icon: const Icon(Icons.menu), // Replace with your desired icon
      //       onPressed: () => Scaffold.of(context).openDrawer(),
      //     ),
      //   ),
      //   actions: [
      //     IconButton(
      //       onPressed: () {
      //         sharedPref.clear();
      //         Navigator.pushAndRemoveUntil(
      //             context,
      //             CupertinoPageRoute(builder: (context) => const LoginPage()),
      //             (route) => false);
      //       },
      //       icon: const Icon(
      //         Icons.exit_to_app,
      //       ),
      //     ),
      //   ],
      // ),
      drawer: DPages(
        id: sharedPref.getString('id').toString(),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                'assets/First.jpg',
                fit: BoxFit.fill,
              ),
            ),
            Builder(
              builder: (context) => IconButton(
                color: Colors.white,
                icon: const Icon(Icons.menu), // Replace with your desired icon
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
            Positioned(
              right: 0,
              child: IconButton(
                color: Colors.white,
                onPressed: () {
                  sharedPref.clear();
                  Navigator.pushAndRemoveUntil(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => const LoginPage()),
                      (route) => false);
                },
                icon: const Icon(
                  Icons.exit_to_app,
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.29,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Text(
                            'Where Are You Going Today? ',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Pickup Station',
                              style: TextStyle(color: Colors.grey),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            DropdownButtonFormField<String>(
                              value: selectedFromCity,
                              focusColor: Colors.transparent,
                              hint: const Text('Choose Departure Station'),
                              items: egyptianCities
                                  .map((city) => DropdownMenuItem<String>(
                                        value: city,
                                        child: Text(city),
                                      ))
                                  .toList(),
                              onChanged: (value) =>
                                  setState(() => selectedFromCity = value),
                              validator: (value) =>
                                  value == null ? 'Please select a city' : null,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(12.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(20.0),
                                    right:
                                        Radius.circular(0.0), // Stadium effect
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(20.0),
                                    right: Radius.circular(0.0),
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: IconButton(
                                icon: const Icon(Icons.swap_horiz),
                                onPressed: _swapCities,
                              ),
                            ),
                            const Text(
                              'Arrival Station',
                              style: TextStyle(color: Colors.grey),
                            ),
                            const SizedBox(
                              height: 5,
                            ),

                            DropdownButtonFormField<String>(
                              value: selectedToCity,
                              focusColor: Colors.transparent,
                              hint: const Text('Choose Arrival Station'),
                              items: egyptianCities
                                  .map((city) => DropdownMenuItem<String>(
                                        value: city,
                                        child: Text(city),
                                      ))
                                  .toList(),
                              onChanged: (value) =>
                                  setState(() => selectedToCity = value),
                              validator: (value) =>
                                  value == null ? 'Please select a city' : null,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(12.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.horizontal(
                                    left:
                                        Radius.circular(0.0), // Stadium effect
                                    right: Radius.circular(20.0),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.horizontal(
                                    left:
                                        Radius.circular(0.0), // Stadium effect
                                    right: Radius.circular(20.0),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                const Text('Number of People:'),
                                const SizedBox(width: 10.0),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Provider.of<ThemeProvider>(context)
                                            .isDarkMode
                                        ? Colors.white
                                        : Colors.grey[200],
                                  ),
                                  child: CustomNumberStepper(
                                    value: numberOfPeople,
                                    min: 1,
                                    max: 10, // Adjust max as needed
                                    onChanged: (value) =>
                                        setState(() => numberOfPeople = value),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.calendar_today),
                                      onPressed: () => _selectDate(context),
                                    ),
                                    Container(
                                      height: 40,
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color:
                                            Provider.of<ThemeProvider>(context)
                                                    .isDarkMode
                                                ? Colors.white
                                                : Colors.grey[200],
                                      ),
                                      child: Text(
                                        DateFormat('EEEE, dd-MM-yyyy')
                                            .format(selectedDate),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: _navigateToSearchResults,
                                  style: ElevatedButton.styleFrom(
                                    shape: const StadiumBorder(),
                                  ),
                                  child:
                                      const Icon(Icons.arrow_forward_rounded),
                                ),
                              ],
                            ),

                            const SizedBox(
                              height: 20,
                            ),
                            // const Center(
                            //   child: Text(
                            //     'Booking History',
                            //     style:
                            //         TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                            //   ),
                            // ),
                            // const SizedBox(
                            //   height: 20,
                            // ),
                            // // SizedBox(
                            // //   height: 200,
                            // //   child: FutureBuilder<List<Booking>>(
                            // //     future: getBookings(),
                            // //     builder: (context, snapshot) {
                            // //       if (snapshot.hasData) {
                            // //         final bookings = snapshot.data!;
                            // //         return Column(
                            // //           children: [
                            // //             Expanded(
                            // //               child: ListView.separated(
                            // //                 scrollDirection: Axis.vertical,
                            // //                 itemCount: bookings.length,
                            // //                 separatorBuilder:
                            // //                     (BuildContext context, int index) =>
                            // //                         const SizedBox(
                            // //                   width: 20.0,
                            // //                   height: 20,
                            // //                 ), // Add spacing between items
                            // //                 itemBuilder:
                            // //                     (BuildContext context, int index) {
                            // //                   final booking = bookings[index];
                            // //                   return BookingRecord(booking: booking);
                            // //                 },
                            // //               ),
                            // //             ),
                            // //           ],
                            // //         );
                            // //       }
                            // //       if (snapshot.connectionState ==
                            // //           ConnectionState.waiting) {
                            // //         return const Center(
                            // //           child: CircularProgressIndicator(
                            // //             color: Colors.black,
                            // //           ),
                            // //         );
                            // //       } else {
                            // //         return const Center(
                            // //           child: Text('No bus information found.'),
                            // //         ); // No data found message
                            // //       }
                            // //     },
                            // //   ),
                            // // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
