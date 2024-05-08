import 'package:flutter/material.dart';

class HomeScreenGreetingsLayout extends StatelessWidget {
  const HomeScreenGreetingsLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.00),
              child: Text(
                "Hi, Alex",
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.00),
              child: Text(
                "Today, 11 Oct",
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
