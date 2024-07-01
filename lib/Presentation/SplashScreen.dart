import 'dart:async';
import 'package:buss/Presentation/HomePage.dart';
import 'package:buss/Presentation/LoginPage.dart';
import 'package:flutter/material.dart';

import '../PageView/PageWidget.dart';
import '../main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const ImageSliderPage(),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 200,
              child: Image.asset('assets/ApplicationLogo.jpg'),
            ), // Replace with your logo image path
            const Text(
              'Welcome To PRTSPD',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 15,
            ),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
