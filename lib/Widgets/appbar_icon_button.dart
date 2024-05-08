import 'package:flutter/material.dart';

class AppBarIconButton extends StatelessWidget {
  final IconData desiredIcon;

  const AppBarIconButton({super.key, required this.desiredIcon});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: Icon(
        desiredIcon,
        size: 27,
      ),
      color: const Color(0xFF2AA2D6),
    );
  }
}
