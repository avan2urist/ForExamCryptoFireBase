import 'package:flutter/material.dart';

final darktheme = ThemeData(
  primaryColor: const Color.fromARGB(255, 248, 236, 128),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w500,
      fontSize: 20,
    ),
    bodySmall: TextStyle(
      color: Color.fromARGB(110, 255, 255, 255),
      fontWeight: FontWeight.w700,
      fontSize: 14,
    ),
  ),
  scaffoldBackgroundColor: const Color.fromARGB(66, 80, 80, 80),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(66, 114, 114, 114),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 25,
      fontWeight: FontWeight.w700,
    ),
  ),
  dividerColor: Colors.white12,
  listTileTheme: const ListTileThemeData(iconColor: Colors.white),
);
