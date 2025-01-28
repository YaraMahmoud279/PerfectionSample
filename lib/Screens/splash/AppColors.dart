import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Colors.deepPurple;
  static const Color secondary = Colors.amber;
  static const Color lightBackground = Colors.white;
  static const Color darkBackground = Colors.black;
  static const Color lightText = Colors.black87;
  static const Color darkText = Colors.white70;

  static ThemeData lightTheme = ThemeData(
    primaryColor: primary,
    scaffoldBackgroundColor: lightBackground,
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: lightText),
      bodyMedium: TextStyle(color: lightText),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: primary,
    scaffoldBackgroundColor: darkBackground,
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: darkText),
      bodyMedium: TextStyle(color: darkText),
    ),
  );
}
