import 'package:flutter/material.dart';

class ElevatedButtonStyle {
  static ElevatedButtonThemeData getElevatedButtonStyle() =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2AA2D6),
          foregroundColor: Colors.white,
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      );
}
