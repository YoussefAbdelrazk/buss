import 'package:buss/Presentation/LoginPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isDarkMode = false;
  String _currentLanguage = 'en'; // Default language
  bool _isNotificationEnabled = false; // Variable for notification preference

  @override
  void initState() {
    super.initState();
    _loadDarkModePref();
    _loadLanguagePref();
  }

  Future<void> _loadDarkModePref() async {
    final sharedPref = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = sharedPref.getBool('isDarkMode') ?? false;
    });
  }

  Future<void> _toggleNotification(bool value) async {
    final sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setBool('isNotificationEnabled', value);
    setState(() {
      _isNotificationEnabled = value;
    });
  }

  Future<void> _loadLanguagePref() async {
    final sharedPref = await SharedPreferences.getInstance();
    _currentLanguage = sharedPref.getString('language') ?? 'en';
  }

  Future<void> _toggleDarkMode(bool value) async {
    final sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setBool('isDarkMode', value);
    setState(() {
      _isDarkMode = value;
    });
  }

  Future<void> _toggleLanguage(String newLanguage) async {
    final sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setString('language', newLanguage);
    setState(() {
      _currentLanguage = newLanguage;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final Locale currentLocale = Locale(_currentLanguage);

    return Scaffold(
      appBar: AppBar(
        title:
            Text('Settings'.tr(currentLocale)), // Use Text.tr for translation
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.notifications),
            title: Text('Notifications'
                .tr(currentLocale)), // Use Text.tr for translation
            trailing: Switch(
              value: _isNotificationEnabled,
              onChanged: (value) => _toggleNotification(value),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dark_mode),
            title: Text(
                'Dark Mode'.tr(currentLocale)), // Use Text.tr for translation
            trailing: Switch(
              value: themeProvider.isDarkMode,
              onChanged: (value) => themeProvider.toggleDarkMode(value),
            ),
          ),

          // ListTile(
          //   leading: const Icon(Icons.language),
          //   title: Text(
          //       'Language'.tr(currentLocale)), // Use Text.tr for translation
          //   subtitle: Text(_currentLanguage == 'en' ? 'English' : 'عربي'),
          //   trailing: DropdownButton<String>(
          //     value: _currentLanguage,
          //     items: const [
          //       DropdownMenuItem(
          //         value: 'en',
          //         child: Text('English'),
          //       ),
          //       DropdownMenuItem(
          //         value: 'ar',
          //         child: Text('عربي'),
          //       ),
          //     ],
          //     onChanged: (value) {
          //       _toggleLanguage(value!); // Update language and UI
          //     },
          //   ),
          // ),
          // // ... other list tiles with translated text using Text.tr(currentLocale)
          ListTile(
            leading: const Icon(Icons.logout),
            title:
                Text('Logout'.tr(currentLocale)), // Use Text.tr for translation
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              sharedPref.clear();
              Navigator.pushAndRemoveUntil(
                context,
                CupertinoPageRoute(builder: (context) => const LoginPage()),
                (route) => false,
              );
            },
          ),
        ],
        // Closing bracket for children list
      ),
    );
  }
}

// Extension for text translation
extension Translate on String {
  String tr(Locale locale) {
    // Define translations map here (replace with your actual translations)

    // Map for storing translations (replace with your actual translations)
    final Map<String, Map<String, String>> translations = {
      'en': {
        'Settings': 'Settings',
        'Dark Mode': 'Dark Mode',
        'Language': 'Language',
        'English': 'English',
        'عربي': 'Arabic',
        'Logout': 'Logout',
        'Notifications': 'Notifications',
        'On': 'On',
        'Off': 'Off',
      },
      'ar': {
        'Settings': 'إعدادات',
        'Dark Mode': 'الوضع الليلي',
        'Language': 'اللغة',
        'English': 'إنجليزي',
        'عربي': 'عربي',
        'Logout': 'تسجيل خروج',
        'Notifications': 'إشعارات',
        'On': 'تشغيل',
        'Off': 'إيقاف',
      },
    };

    final languageCode = translations[locale.languageCode];
    if (languageCode != null) {
      return languageCode[this] ?? this;
    } else {
      return this;
    }
  }
}
