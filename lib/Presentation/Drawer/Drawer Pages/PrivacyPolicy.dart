import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Privacy Policy',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              'This Privacy Policy describes how [Your Company Name] ("we", "us", or "our") collects, uses, and discloses your information in connection with your use of our mobile application ("App"), services, and website (collectively, the "Service").',
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 20.0),
            Text(
              '1. Information We Collect',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              'We collect several different types of information for various purposes to provide and improve our Service to you.',
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 10.0),
            Text(
              '- Personal Information: While using our Service, we may ask you to provide certain personally identifiable information that can be used to contact or identify you ("Personal Information"). Personal Information may include, but is not limited to, your name, email address, phone number.',
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 10.0),
            Text(
              '- Usage Data: We may also collect information about how you access and use the Service ("Usage Data"). This Usage Data may include information such as your device type, operating system, IP address, browsing activity on our Service, search terms, and the time and date of your visit.',
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 20.0),
            Text(
              '2. Use of Your Information',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              'We use the information we collect for various purposes, including to:',
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 10.0),
            Text(
              '* Provide and maintain the Service',
              textAlign: TextAlign.justify,
            ),
            Text(
              '* Improve, personalize, and expand the Service',
              textAlign: TextAlign.justify,
            ),
            Text(
              '* Develop new products, services, and features',
              textAlign: TextAlign.justify,
            ),
            Text(
              '* Send you marketing and promotional communications (with your consent)',
              textAlign: TextAlign.justify,
            ),
            Text(
              '* Respond to your inquiries and requests',
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 20.0),
            // Add additional sections here... (refer to previous comments)
            Text(
              'You can contact us at [your email address] for any questions about this Privacy Policy.',
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
