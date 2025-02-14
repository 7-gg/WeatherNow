import 'package:flutter/material.dart';

ThemeData appTheme() {
  final Color deepRed = Color(0xFF8B0000); // Bordeaux, dark red color
  return ThemeData(
    primaryColor: deepRed, // Primary color
    hintColor: Color(0xFFD32F2F), // Softer background for screens
    scaffoldBackgroundColor: Color(0xFFF5E0E0), // Scaffold background color
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.black), // Main text
      bodyMedium: TextStyle(color: Colors.black), // Secondary text
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: deepRed, // App bar color
      foregroundColor: Colors.white, // Text color in the app bar
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: deepRed, // Main button color
      textTheme: ButtonTextTheme.primary,
    ),
    iconTheme: IconThemeData(color: deepRed),
    colorScheme: ColorScheme.fromSwatch(
        // ignore: deprecated_member_use
        primarySwatch: MaterialColor(deepRed.value, {
      50: Color(0xFFFAE6E6), // Very light
      100: Color(0xFFF5B2B2), // Light
      200: Color(0xFFF08080), // Less light
      300: Color(0xFFEC4D4D), // A bit darker
      400: Color(0xFFDC1C1C), // Dark
      500: deepRed, // Main color (Bordeaux)
      600: Color(0xFF7A0000), // Darker
      700: Color(0xFF6E0000), // Darker
      800: Color(0xFF5A0000), // Darker
      900: Color(0xFF4A0000), // Very dark
    })).copyWith(surface: Color(0xFFF5E0E0)), // Icon color
  );
}
