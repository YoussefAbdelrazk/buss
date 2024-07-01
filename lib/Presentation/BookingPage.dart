import 'package:buss/Presentation/PaymentPage.dart'; // Import PaymentPage
import 'package:buss/Utils/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../Models/BusInfo.dart';
import '../main.dart';

class BookingPage extends StatefulWidget {
  final BusInfo busInfo;
  final int totalSeats;
  final List<int> SelectedSeats;

  const BookingPage({
    Key? key,
    required this.busInfo,
    required this.totalSeats,
    required this.SelectedSeats,
  }) : super(key: key);

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final int numofbookings = sharedPref.getInt('numberofbookings') ?? 0;
  bool? isDark = sharedPref.getBool('isDarkMode');
  String passengerName = '';
  String passengerPhone = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  double calculateDiscountedPrice(double totalPrice, int numberOfBookings) {
    if (numberOfBookings > 5) {
      // Apply 15% discount if bookings are more than 5
      final discount = totalPrice * 0.15;
      return totalPrice - discount;
    } else if (numberOfBookings == 0) {
      // No discount or special handling for 0 bookings
      return totalPrice; // Or any other value you prefer for 0 bookings
    } else {
      // Bookings between 1 and 5 (no discount applied)
      return totalPrice;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double totalPrice =
        sharedPref.getInt("numberOfPeople")! * widget.busInfo.price;
    final totaldiscount = calculateDiscountedPrice(totalPrice, numofbookings);
    sharedPref.setDouble("totalPrice", totalPrice);
    final formatter = DateFormat('HH:mm a'); // Customize format here
    final formattedDepartureTime =
        formatter.format(widget.busInfo.departureTime);
    final formattedArrivalTime = formatter.format(widget.busInfo.arrivalTime);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Image.asset('assets/Information.jpg'),
              ),
              const SizedBox(height: 10),
              const Text(
                'Bus Information:',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        child: Image.network(
                          "$linkImageRoot/${widget.busInfo.companyLogo}",
                          fit: BoxFit.fill,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '${widget.busInfo.companyName} ',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Departure Time: ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color:
                                Provider.of<ThemeProvider>(context).isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: ' $formattedDepartureTime',
                          style: TextStyle(
                            color:
                                Provider.of<ThemeProvider>(context).isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Arrival Time: ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color:
                                Provider.of<ThemeProvider>(context).isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: ' $formattedArrivalTime',
                          style: TextStyle(
                            color:
                                Provider.of<ThemeProvider>(context).isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Total Seats: ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color:
                                Provider.of<ThemeProvider>(context).isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: ' ${sharedPref.getInt("numberOfPeople")} seats',
                          style: TextStyle(
                            color:
                                Provider.of<ThemeProvider>(context).isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Total Price:',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Provider.of<ThemeProvider>(context).isDarkMode
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    numofbookings <= 5
                        ? const TextSpan()
                        : TextSpan(
                            text: ' $totalPrice EGP',
                            style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              fontWeight: FontWeight.bold,
                              color:
                                  Provider.of<ThemeProvider>(context).isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                            ),
                          ),
                    TextSpan(
                      text: '  $totaldiscount EGP',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Provider.of<ThemeProvider>(context).isDarkMode
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              const Center(
                child: Text(
                  'Passenger Information:',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20.0),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null; // No validation error
                      },
                      decoration: InputDecoration(
                        prefixIconColor:
                            Provider.of<ThemeProvider>(context).isDarkMode
                                ? Colors.white
                                : Colors.grey,
                        prefixIcon: const Icon(Icons.person),
                        labelText: 'Name',
                        labelStyle: TextStyle(
                          color: Provider.of<ThemeProvider>(context).isDarkMode
                              ? Colors.white
                              : Colors.grey,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color:
                                Provider.of<ThemeProvider>(context).isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      onChanged: (value) =>
                          setState(() => passengerName = value),
                    ),
                    const SizedBox(height: 10.0),
                    TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(11)
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        if (value.length < 11) {
                          return 'Please enter valid phone number';
                        }
                        return null; // No validation error (more complex validation can be added)
                      },
                      decoration: InputDecoration(
                        prefixText: '+2 ',
                        prefixIconColor:
                            Provider.of<ThemeProvider>(context).isDarkMode
                                ? Colors.white
                                : Colors.grey,
                        prefixIcon: const Icon(Icons.phone),
                        labelText: 'Phone Number',
                        labelStyle: TextStyle(
                          color: Provider.of<ThemeProvider>(context).isDarkMode
                              ? Colors.white
                              : Colors.grey,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                      onChanged: (value) =>
                          setState(() => passengerPhone = value),
                    ),
                    const SizedBox(height: 20.0),
                  ],
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Validate the form using the Form's key
                    if (_formKey.currentState!.validate()) {
                      // Navigate to PaymentPage if validation is successful
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentPage(
                            totalPrice: totaldiscount,
                            passengerName: passengerName,
                            passengerPhone: passengerPhone,
                            busInfo: widget.busInfo,
                            totalSeats: sharedPref.getInt("numberOfPeople")!,
                            SelectedSeats: widget.SelectedSeats,
                          ),
                        ),
                      );
                      print(widget.SelectedSeats);
                    } else {
                      // Optional: Show a snackbar or other visual cue to indicate validation errors
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Please fix form errors to proceed')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    alignment: Alignment.center,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text('Proceed to Payment'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
