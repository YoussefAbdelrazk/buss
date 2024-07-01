import 'package:buss/Presentation/Drawer/Drawer%20Pages/BookingHistoryPage.dart';
import 'package:buss/Presentation/Drawer/Drawer%20Pages/BusCompanies.dart';
import 'package:buss/Presentation/Drawer/Drawer%20Pages/SettingsPage.dart';
import 'package:buss/Presentation/UserPage.dart';
import 'package:buss/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../LoginPage.dart';
import 'Drawer Pages/AboutUsPage.dart';
import 'Drawer Pages/Help&Support.dart';
import 'Drawer Pages/PrivacyPolicy.dart';
import 'Drawer Pages/Terms&Conditions.dart';

class DPages extends StatelessWidget {
  const DPages({
    super.key,
    required this.id,
  });

  final id;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.75,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
            child: Row(
              children: [
                const SizedBox(width: 16.0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${sharedPref.getString('username')}',
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ListTile(
            title: const Text('Account Settings'),
            leading: const Icon(Icons.settings),
            onTap: () {
              Navigator.pop(context); // Close drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
          ),
          ListTile(
            title: const Text('User Profile'),
            leading: const Icon(Icons.person),
            onTap: () {
              Navigator.pop(context); // Close drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UserPage()),
              );
            },
          ),
          ListTile(
            title: const Text('Terms & Conditions'),
            leading: const Icon(Icons.list),
            onTap: () {
              Navigator.pop(context); // Close drawer
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TermsAndConditionsPage(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Privacy Policy'),
            leading: const Icon(Icons.policy),
            onTap: () {
              Navigator.pop(context); // Close drawer
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PrivacyPolicyPage()),
              );
            },
          ),
          ListTile(
            title: const Text('Booking History'),
            leading: const Icon(Icons.history),
            onTap: () {
              Navigator.pop(context); // Close drawer
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookingHistoryPage(
                    id: id,
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Help & Support'),
            leading: const Icon(Icons.help_center),
            onTap: () {
              Navigator.pop(context); // Close drawer
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const HelpAndSupportPage()),
              );
            },
          ),
          ListTile(
            title: const Text('About Us'),
            leading: const Icon(Icons.info),
            onTap: () {
              Navigator.pop(context); // Close drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutUsPage()),
              );
            },
          ),
          ListTile(
            title: const Text('Associated Companies'),
            leading: const Icon(Icons.assessment),
            onTap: () {
              // Handle account settings navigation
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BusCompanies()),
              );
              // Navigate to account settings page
            },
          ),
          ListTile(
            title: const Text('Log Out'),
            leading: const Icon(Icons.logout),
            onTap: () {
              sharedPref.clear();
              Navigator.pushAndRemoveUntil(
                  context,
                  CupertinoPageRoute(builder: (context) => const LoginPage()),
                  (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
