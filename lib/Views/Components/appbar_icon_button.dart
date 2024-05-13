import 'package:flutter/material.dart';

class AppBarIconButton extends StatelessWidget {
  final IconData desiredIcon;
  final Function onPressed;

  const AppBarIconButton({
    super.key,
    required this.desiredIcon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => onPressed(),
      icon: Icon(
        desiredIcon,
        size: 27,
      ),
      color: const Color(0xFF2AA2D6),
    );
  }
}
