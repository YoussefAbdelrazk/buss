import 'package:flutter/material.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms & Conditions'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Terms and Conditions',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              'Welcome to our Terms and Conditions ("Terms" or "Terms and Conditions"). These Terms govern your use of our mobile application ("App"), services, and website (collectively, the "Service") operated by [Your Company Name] ("we", "us", or "our").',
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 20.0),
            Text(
              '1. Acceptance of Terms',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              'By accessing or using the Service, you agree to be bound by these Terms. If you disagree with any part of the terms then you may not access or use the Service.',
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 20.0),
            Text(
              '2. Account Creation (if applicable)',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              'If you create an account with the Service, you are responsible for maintaining the confidentiality of your account and password and for restricting access to your device. You agree to accept responsibility for all activities that occur under your account or password.',
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 20.0),
            Text(
              '3. User Content (if applicable)',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              'The Service may allow you to post, upload, or submit content ("User Content"). You retain all ownership rights to your User Content. By submitting User Content, you grant us a non-exclusive, royalty-free, worldwide license to use, modify, publish, and translate your User Content for the sole purpose of providing and improving the Service.',
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 20.0),
            // Add additional sections here... (refer to previous comments)
            Text(
              'You can contact us at [your email address] for any questions about these Terms and Conditions.',
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
