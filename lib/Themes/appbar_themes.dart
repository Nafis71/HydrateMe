import 'package:flutter/material.dart';

class AppbarTheme{
  static getAppbarTheme() => const AppBarTheme(
    backgroundColor: Colors.white,
    titleTextStyle: TextStyle(
      color: Color(0xFF2AA2D6),
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
  );
}