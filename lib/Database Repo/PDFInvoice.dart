import 'dart:io';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../Models/BusInfo.dart';

class PdfInvoice {
  static Future<void> generate(BusInfo busInfo, int totalSeats,
      String passengerName, String passengerPhone, String savePath) async {
    // Create a new PDF document
    final pdf = pw.Document();

    // Add a page with booking information
    // Add a page with booking information
    pdf.addPage(
      pw.Page(
        build: (context) => pw.Column(
          children: [
            // Top section with decoration (replace with desired colors/images)
            pw.Container(
              height: 50.0,
              color: PdfColor.fromHex('#afc1de'),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                children: [
                  pw.Text(
                    'Bus Booking Confirmation',
                    style: pw.TextStyle(
                      fontSize: 18.0, // Slightly larger font size
                      color: PdfColor.fromHex('#ffffff'),
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Text(
                    '${DateTime.now().year}', // Display current year
                    style: pw.TextStyle(
                      fontSize: 12.0,
                      color: PdfColor.fromHex('#ffffff'),
                    ),
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 20.0),

            // Bus information section
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(
                  'Bus Information:',
                  style: pw.TextStyle(
                      fontSize: 16.0, fontWeight: pw.FontWeight.bold),
                ),
                pw.Text(
                  'Ticket ID: ${DateTime.now().millisecondsSinceEpoch}', // Generate unique ID
                  style: const pw.TextStyle(fontSize: 12.0),
                ),
              ],
            ),
            pw.SizedBox(height: 10.0),
            pw.Text('Company: ${busInfo.companyName}'),
            pw.SizedBox(height: 10.0),
            pw.Text('Departure Time: ${busInfo.departureTime}'),
            pw.SizedBox(height: 10.0),
            pw.Text('Arrival Time: ${busInfo.arrivalTime}'),
            pw.SizedBox(height: 10.0),
            pw.Text('Total Seats: $totalSeats seats'),
            pw.SizedBox(height: 10.0),
            pw.Text('Total Price: ${totalSeats * busInfo.price} EGP'),

            pw.SizedBox(height: 20.0),

            // Passenger information section
            pw.Text(
              'Passenger Information:',
              style:
                  pw.TextStyle(fontSize: 16.0, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 10.0),
            pw.Text('Name: $passengerName'),
            pw.SizedBox(height: 10.0),
            pw.SizedBox(height: 10.0),
            pw.Text('Phone Number: $passengerPhone'),
          ],
        ),
      ),
    ); // Validate and handle the provided save path
    if (savePath.isEmpty || !Directory(savePath).existsSync()) {
      print('Invalid save path provided.');
      return;
    }

    // Create a unique file name with timestamp
    final now = DateTime.now();
    final fileName = '$savePath/bus_booking_${now.millisecondsSinceEpoch}.pdf';

    // Save the PDF document to the specified file
    try {
      final file = File(fileName);
      final pdfData = await pdf.save();
      await file.writeAsBytes(pdfData);

      print('PDF generated successfully: $fileName');
    } catch (error) {
      print('Error creating PDF: $error');
    }
  }
}
