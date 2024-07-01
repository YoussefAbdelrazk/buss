// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:buss/Database%20Repo/Crud.dart';
import 'package:buss/Models/BusInfo.dart';
import 'package:buss/Presentation/ConfirmBooking.dart';
import 'package:buss/Utils/ExpiryDateFormatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../Utils/Constants.dart';
import '../main.dart';

class PaymentPage extends StatefulWidget {
  final String passengerName;
  final String passengerPhone;
  final BusInfo busInfo;
  final int totalSeats;
  final num totalPrice;
  final List<int> SelectedSeats;

  const PaymentPage({
    Key? key,
    required this.passengerName,
    required this.passengerPhone,
    required this.busInfo,
    required this.totalSeats,
    required this.totalPrice,
    required this.SelectedSeats,
  }) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final _formKey = GlobalKey<FormState>(); // Key for form validation
  String cardNumber = '';
  String cvv = '';
  String expiryDate = '';
  String cardholderName = '';

  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController cardholderNameController =
      TextEditingController();

  Crud crud = Crud();

  Future<void> addBooking({
    required int userId,
    required int busInfoId,
    required int numberOfSeats,
  }) async {
    final serializedSeats = jsonEncode(widget.SelectedSeats);
    // Prepare request body with booking details
    final response = await crud.PostRequest(
      linkAddBookingName, // Replace with your actual URL
      {
        "user_id": userId.toString(),
        "bus_info_id": busInfoId.toString(),
        "number_of_seats": numberOfSeats.toString(),
        "booking_date": DateTime.now().toIso8601String(),
        "status": "Accepted", // Or based on your logic
        "booked_seats": serializedSeats,
      },
    );
  }

  Future<void> addPayment() async {
    if (_formKey.currentState!.validate()) {
      cardNumber = cardNumberController.text;
      cvv = cvvController.text;
      expiryDate = expiryDateController.text;
      cardholderName = cardholderNameController.text;

      // Prepare request body with payment details
      final response = await crud.PostRequest(
        linkAddPaymentName, // Replace with your actual URL
        {
          "card_number": cardNumber.toString(), // Convert to String if needed
          "card_holder_name": cardholderName,
          "expiry_date": expiryDate.toString(), // Convert to String if needed
          "cvv": cvv.toString(), // Convert to String if needed
          "amount":
              widget.totalPrice.toString(), // Assuming it's already a double
          "status": 'Pending',
        },
      );
      if (response['status'] == "success") {
        try {
          await addBooking(
            userId: int.parse(
              sharedPref.getString('id')!,
            ), // Replace with actual value
            busInfoId:
                widget.busInfo.businfoid, // Assuming busInfo has an ID property
            numberOfSeats: widget.totalSeats,
          );
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ConfirmationPage(
                busInfo: widget.busInfo,
                totalSeats: widget.totalSeats,
                passengerName: widget.passengerName,
                passengerPhone: widget.passengerPhone,
              ),
            ),
          );
        } catch (e) {
          // Handle booking failure in a user-friendly way
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Booking failed! Please try again.'),
            ),
          );
        }
      } else {
        // Handle payment failure
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Payment failed!'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('HH:mm a'); // Customize format here
    final formattedDepartureTime =
        formatter.format(widget.busInfo.departureTime);
    final formattedArrivalTime = formatter.format(widget.busInfo.arrivalTime);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        child: Form(
          key: _formKey, // Assign the form key
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/Payment.png'),
              const SizedBox(
                height: 10,
              ),
              const Center(
                child: Text(
                  'Booking Summary:',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Row(
                        children: [
                          CircleAvatar(
                            child: Image.network(
                              "$linkImageRoot/${widget.busInfo.companyLogo}",
                              fit: BoxFit.fill,
                            ),
                          ),
                          Text(
                            '${widget.busInfo.companyName} ',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Card(
                      color: Colors.grey[200],

                      shape: const StadiumBorder(),
                      //  decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(20),
                      //     color: Provider.of<ThemeProvider>(context).isDarkMode
                      //         ? Colors.white
                      //         : const Color.fromRGBO(154, 181, 247, 1),
                      //   ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 10),
                        child: Column(
                          children: [
                            Text(
                              'Departure Time: $formattedDepartureTime ',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Arrival Time: $formattedArrivalTime",
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5.0),
              Card(
                color: Colors.grey[200],
                shape: const StadiumBorder(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Total Seats: ${widget.totalSeats} seats',
                    style: const TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 5.0),
              Card(
                color: Colors.grey[200],
                shape: const StadiumBorder(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Total Price:  ${widget.totalPrice} EGP',
                    style: const TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              const Center(
                child: Text(
                  'Payment Information:',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10.0),
              Card(
                color: Colors.grey[200],
                shape: const StadiumBorder(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Name: ${widget.passengerName}',
                    style: const TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 5.0),
              Card(
                color: Colors.grey[200],
                shape: const StadiumBorder(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Phone: ${widget.passengerPhone}',
                    style: const TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  const Center(
                    child: Text(
                      'Card Information:',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: cardholderNameController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      prefixIconColor:
                          Provider.of<ThemeProvider>(context).isDarkMode
                              ? Colors.white
                              : Colors.grey,
                      prefixIcon: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Icon(Icons.person_2),
                      ),
                      labelText: 'Cardholder Name',
                      labelStyle: const TextStyle(color: Colors.grey),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter cardholder name';
                      }
                      return null;
                    },
                    onSaved: (value) =>
                        cardholderName = value!, // Save entered value
                  ),
                  const SizedBox(height: 10.0),
                  TextFormField(
                    controller: cardNumberController,

                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(16),
                      CardNumberInputFormatter(),
                    ],
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      prefixIconColor:
                          Provider.of<ThemeProvider>(context).isDarkMode
                              ? Colors.white
                              : Colors.grey,
                      prefixIcon: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Icon(Icons.credit_card),
                      ),
                      labelText: 'Card Number',
                      labelStyle: const TextStyle(color: Colors.grey),
                    ),

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter card number';
                      }
                      return null;
                    },
                    onSaved: (value) =>
                        cardNumber = value!, // Save entered value
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      Flexible(
                        child: TextFormField(
                          controller: cvvController,

                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(3),
                          ],
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            prefixIconColor:
                                Provider.of<ThemeProvider>(context).isDarkMode
                                    ? Colors.white
                                    : Colors.grey,
                            prefixIcon: const Icon(Icons.numbers),
                            labelText: 'CVV',
                            labelStyle: const TextStyle(color: Colors.grey),
                          ),
                          keyboardType: TextInputType.number,
                          obscureText: true, // Hide CVV input
                          // Limit CVV to 3 digits
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter CVV';
                            }
                            return null;
                          },
                          onSaved: (value) =>
                              cvv = value!, // Save entered value
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Flexible(
                        child: TextFormField(
                          controller: expiryDateController,

                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            ExpiryDateInputFormatter(),
                            LengthLimitingTextInputFormatter(
                                5), // Limit to 5 characters (MM/YY)
                          ],
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            prefixIconColor:
                                Provider.of<ThemeProvider>(context).isDarkMode
                                    ? Colors.white
                                    : Colors.grey,
                            prefixIcon: const Icon(Icons.date_range),
                            labelText: 'Expiry Date (MM/YY)',
                            labelStyle: const TextStyle(color: Colors.grey),
                          ),
                          keyboardType: TextInputType.datetime,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter expiry date';
                            }

                            // Check format (MM/YY)
                            if (value.length != 5 ||
                                value.contains(RegExp(r'[^\d/]')) ||
                                !value.contains('/')) {
                              return 'Invalid expiry date format (MM/YY)';
                            }

                            // Validate month (1-12)
                            final month =
                                int.tryParse(value.substring(0, 2)) ?? 0;
                            if (month < 1 || month > 12) {
                              return 'Invalid month (1-12)';
                            }

                            // Validate year (future year)
                            final currentYear = DateTime.now().year;
                            final year = int.tryParse(value.substring(3)) ?? 0;
                            if (year < currentYear % 100) {
                              return 'Expired card'; // Assuming validation for cards expiring this year (YY)
                            }

                            return null;
                          },
                          onSaved: (value) =>
                              expiryDate = value!, // Save entered value
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30.0),
                ],
              ),
              Center(
                child: ElevatedButton(
                  onPressed: addPayment,
                  //  () {
                  //   if (_formKey.currentState!.validate()) {
                  //     _formKey.currentState!.save(); // Trigger form saving

                  //     // Implement your logic to process payment
                  //     // Replace with actual payment processing (e.g., integration with a payment gateway)
                  //     print(
                  //         'Processing payment for ${widget.passengerName}...');
                  //     // Simulate successful payment
                  //     Future.delayed(const Duration(seconds: 2), () {
                  //       Navigator.pushReplacement(
                  //         context,
                  //         MaterialPageRoute(
                  //           builder: (context) => ConfirmationPage(
                  //             passengerName: widget.passengerName,
                  //             passengerPhone: widget.passengerPhone,
                  //             busInfo: widget.busInfo,
                  //             totalSeats: widget.totalSeats,
                  //           ),
                  //         ),
                  //       );
                  //     });
                  //   }
                  // },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text('Proceed to Booking'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    String inputData = newValue.text;
    StringBuffer buffer = StringBuffer();
    for (var i = 0; i < inputData.length; i++) {
      buffer.write(inputData[i]);
      int index = i + 1;

      if (index % 4 == 0 && inputData.length != index) {
        buffer.write("  ");
      } // double space
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.toString().length),
    );
  }
}
