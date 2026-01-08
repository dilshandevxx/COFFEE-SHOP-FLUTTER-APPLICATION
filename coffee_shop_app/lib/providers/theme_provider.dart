import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeProvider extends ChangeNotifier {
  // Initially Dark Mode
  ThemeMode _themeMode = ThemeMode.dark;

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    _themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  // Dark Theme
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.orange,
    scaffoldBackgroundColor: Colors.grey[900],
    colorScheme: ColorScheme.dark(
      surface: Colors.grey[800]!, // Card color
      primary: Colors.orange,
      secondary: Colors.grey[700]!,
    ),
    textTheme: GoogleFonts.soraTextTheme(ThemeData.dark().textTheme),
  );

  // Light Theme
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.orange,
    scaffoldBackgroundColor: Colors.grey[300],
    colorScheme: ColorScheme.light(
      surface: Colors.white, // Card color
      primary: Colors.orange,
      secondary: Colors.grey[200]!,
    ),
    textTheme: GoogleFonts.soraTextTheme(ThemeData.light().textTheme),
  );
}
