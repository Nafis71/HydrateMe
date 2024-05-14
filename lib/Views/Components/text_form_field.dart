import 'package:flutter/material.dart';

class FormTextField extends StatelessWidget {
  final String hintText, errorText, regExpression;
  final TextInputType textInputType;
  final TextEditingController controller;

  const FormTextField({
    super.key,
    required this.hintText,
    required this.errorText,
    required this.regExpression,
    required this.textInputType,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: textInputType,
      cursorOpacityAnimates: true,
      cursorColor: Colors.blue,
      decoration: InputDecoration(
        labelText: hintText,
        labelStyle: const TextStyle(color: Colors.black),
        hintText: hintText,
        hintMaxLines: 1,
      ),
      validator: (value) {
        if (value!.isEmpty || !RegExp(regExpression).hasMatch(value)) {
          return errorText;
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
