import 'package:flutter/material.dart';

class OnboardPageCounter extends StatelessWidget {
  final int currentIndex, index;
  const OnboardPageCounter({super.key, required this.currentIndex, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      width: (currentIndex == index) ? 25 : 10,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.blue,
      ),
    );
  }
}
