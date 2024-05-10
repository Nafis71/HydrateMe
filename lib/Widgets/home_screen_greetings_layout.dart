import 'package:flutter/material.dart';
import 'package:water_tracker/Models/person_data.dart';

class HomeScreenGreetingsLayout extends StatelessWidget {
  final PersonData personData = PersonData();
  HomeScreenGreetingsLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.00),
              child: Text(
                "Hi, ${personData.getName}",
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
        const Row(
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
