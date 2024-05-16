import 'package:flutter/material.dart';

MaterialBanner appBanner(
        {required String content,
        required Color color,
        required BuildContext context}) {
  ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
  return MaterialBanner(
    content: Text(content, style: const TextStyle(
      color: Colors.white,
      fontSize: 16,
    ),),
    backgroundColor: color,
    elevation: 5,
    padding: const EdgeInsets.all(10.00),
    onVisible: () {
      Future.delayed(const Duration(seconds: 2),
              () => ScaffoldMessenger.of(context).hideCurrentMaterialBanner());
    },
    actions: [
      TextButton(
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
        },
        child: const Text(
          "Close",
          style: TextStyle(
            fontSize: 17,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      )
    ],
  );
}
