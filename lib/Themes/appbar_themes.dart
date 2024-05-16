import 'package:flutter/material.dart';
import 'package:water_tracker/Utils/colors.dart';

class AppbarTheme{
  static getAppbarTheme() => const AppBarTheme(
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.white,
    titleTextStyle: TextStyle(
      color: appPrimaryColor,
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
  );
}