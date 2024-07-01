import 'package:flutter/material.dart';

class HelpAndSupportPage extends StatelessWidget {
  const HelpAndSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Help & Support',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              'We\'re here to help! Find answers to frequently asked questions or contact us directly.',
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 20.0),
            Text(
              'FAQs (Frequently Asked Questions)',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              'Find answers to some of our most common questions below. If you can\'t find what you\'re looking for, feel free to contact us.',
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 10.0),
            // Add FAQ questions and answers here as ListTile widgets
            ListTile(
              title: Text('How do I book a bus ticket?'),
              subtitle: Text(
                'Booking a bus ticket is easy! Simply enter your origin, destination, travel date, and search for available buses. Select your preferred option, complete the passenger details, and proceed to payment. Your ticket will be sent to your email.',
              ),
            ),
            SizedBox(height: 10.0),
            ListTile(
              title: Text('What payment methods do you accept?'),
              subtitle: Text(
                'We currently accept payments through credit cards, debit cards, and some popular mobile wallets.',
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Contact Us',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              'If you can\'t find the answer to your question in our FAQs, feel free to contact us using the following methods:',
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 10.0),
            Row(
              children: [
                Icon(Icons.email),
                SizedBox(width: 10.0),
                Text('support@busbookingapp.com'),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              children: [
                Icon(Icons.phone),
                SizedBox(width: 10.0),
                Text('+123 456 7890'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
