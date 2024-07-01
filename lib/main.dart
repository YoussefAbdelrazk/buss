import 'package:buss/PageView/PageWidget.dart';
import 'package:buss/Presentation/HomePage.dart'; // Import for HomePage
import 'package:buss/Presentation/LoginPage.dart'; // Import for LoginPage
import 'package:buss/Presentation/SeatBooking.dart'; // Import for SeatBooking (optional)
import 'package:buss/Presentation/SplashScreen.dart';
import 'package:buss/Presentation/UserPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart'; // Provider for state management

late SharedPreferences sharedPref;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPref = await SharedPreferences.getInstance();
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode =
      sharedPref.getBool('isDarkMode') ?? false; // Default to false

  bool get isDarkMode => _isDarkMode;

  void toggleDarkMode(bool value) async {
    _isDarkMode = value;
    await sharedPref.setBool('isDarkMode', value);
    notifyListeners(); // Notify listeners about the change
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      // theme: ThemeData(
      //   // Primary color for buttons, sliders, etc. (adjust as needed)
      //   primaryColor: isDarkMode ? Colors.white : Colors.black,
      //   iconTheme: IconThemeData(
      //     color: isDarkMode
      //         ? Colors.white
      //         : Colors.black, // Set to white in dark mode
      //   ),

      //   iconButtonTheme: IconButtonThemeData(
      //     style: IconButton.styleFrom(
      //       backgroundColor: isDarkMode ? Colors.white : Colors.black,
      //     ),
      //   ),



      //   // Color scheme for app bars, buttons, etc.
      //   colorScheme: ColorScheme(
      //     brightness: isDarkMode ? Brightness.dark : Brightness.light,
      //     primary: isDarkMode
      //         ? Colors.black
      //         : const Color.fromRGBO(123, 150, 250, 1), // Customize as needed
      //     secondary: Colors.teal, // Example secondary color
      //     background: isDarkMode ? Colors.black : Colors.white,
      //     surface: isDarkMode ? Colors.black : Colors.white,
      //     error: const Color.fromRGBO(123, 150, 250, 1),
      //     onPrimary: isDarkMode ? Colors.black : Colors.white,
      //     onSecondary: Colors.white, // Example onSecondary
      //     onBackground: isDarkMode ? Colors.white : Colors.black,
      //     onSurface: isDarkMode ? Colors.white : Colors.black,
      //     onError: const Color.fromRGBO(123, 150, 250, 1),
      //   ),

      //   elevatedButtonTheme: ElevatedButtonThemeData(
      //     style: ElevatedButton.styleFrom(foregroundColor: Colors.white,backgroundColor:  Colors.black),
      //   ),

      //   // Scaffold background color
      //   scaffoldBackgroundColor: isDarkMode ? Colors.black : Colors.white,

      //   appBarTheme: AppBarTheme(
      //     backgroundColor: Colors.white, // Set app bar background to white
      //     elevation: 0,
      //     iconTheme: IconThemeData(
      //       color: isDarkMode
      //           ? Colors.white
      //           : Colors.black, // Set to white in dark mode
      //     ),
      //     titleTextStyle: Theme.of(context)
      //         .textTheme
      //         .bodyLarge!
      //         .copyWith(fontSize: 30, fontWeight: FontWeight.bold),
      //   ),

      //   // Text theme for headings, body text, etc.
      //   textTheme: TextTheme(
      //     headlineLarge: TextStyle(
      //       color: isDarkMode ? Colors.white : Colors.black,
      //       fontSize: 32.0,
      //     ),
      //     bodyLarge: TextStyle(
      //       color: isDarkMode ? Colors.white : Colors.black,
      //       fontSize: 16.0,
      //     ),
      //   ),
      // ),
     
      home: const SplashScreen(),
    );
  }
}
