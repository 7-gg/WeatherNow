import 'package:flutter/material.dart';

ThemeData appTheme() {
  final Color deepRed = Color(0xFF8B0000); // Bordeaux, couleur rouge foncé
  return ThemeData(
    primaryColor: deepRed, // Couleur primaire
    hintColor: Color(0xFFD32F2F), // Fond plus doux pour les écrans
    scaffoldBackgroundColor: Color(0xFFF5E0E0), // Fond du Scaffold
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.black), // Texte principal
      bodyMedium: TextStyle(color: Colors.black), // Texte secondaire
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: deepRed, // Couleur de la barre d'applications
      foregroundColor: Colors.white, // Couleur du texte dans la barre
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: deepRed, // Couleur des boutons principaux
      textTheme: ButtonTextTheme.primary,
    ),
    iconTheme: IconThemeData(color: deepRed),
    colorScheme: ColorScheme.fromSwatch(
        primarySwatch: MaterialColor(deepRed.value, {
      50: Color(0xFFFAE6E6), // Très clair
      100: Color(0xFFF5B2B2), // Clair
      200: Color(0xFFF08080), // Moins clair
      300: Color(0xFFEC4D4D), // Un peu plus foncé
      400: Color(0xFFDC1C1C), // Fonçé
      500: deepRed, // Couleur principale (bordeaux)
      600: Color(0xFF7A0000), // Plus foncé
      700: Color(0xFF6E0000), // Plus foncé
      800: Color(0xFF5A0000), // Plus foncé
      900: Color(0xFF4A0000), // Très foncé
    })).copyWith(background: Color(0xFFF5E0E0)), // Couleur des icônes
  );
}
