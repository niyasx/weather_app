import 'package:flutter/material.dart';
import 'package:weather_app/constants/colors.dart';

class ThemeManager {
  static ThemeData lightTheme = ThemeData(
      primaryColor: ThemeData.light().scaffoldBackgroundColor,
      colorScheme: const ColorScheme.light().copyWith(
        primary: lighPrimaryColor,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromARGB(255, 165, 188, 229),
      ));

  static ThemeData darkTheme = ThemeData(
      primaryColor: ThemeData.dark().scaffoldBackgroundColor,
      colorScheme: const ColorScheme.dark().copyWith(primary: darkPrimaryColor),
      appBarTheme: AppBarTheme(backgroundColor: bluegrey));
}
