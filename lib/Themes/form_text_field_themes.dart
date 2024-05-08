import 'package:flutter/material.dart';

class FormTextFieldThemes {
  static InputDecorationTheme getFormTextFieldDecoration() =>
      InputDecorationTheme(
        hintFadeDuration: const Duration(milliseconds: 800),
        isDense: false,
        contentPadding: const EdgeInsets.all(20.00),
        enabledBorder: getNormalBorder(color: const Color(0xffE3F2FD)),
        focusedBorder: getNormalBorder(),
        errorBorder: getErrorBorder(),
        focusedErrorBorder: getErrorBorder(),
      );

  static OutlineInputBorder getErrorBorder() => const OutlineInputBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30.00),
          topRight: Radius.circular(30.00),
        ),
        borderSide: BorderSide(
          color: Colors.red,
          width: 2,
        ),
      );

  static OutlineInputBorder getNormalBorder({Color? color}) =>
      OutlineInputBorder(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30.00),
          topRight: Radius.circular(30.00),
        ),
        borderSide: BorderSide(
          color: (color != null) ? color : Colors.blue,
          width: 1.7,
        ),
      );
}
