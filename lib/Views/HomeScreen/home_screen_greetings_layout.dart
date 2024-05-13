import 'package:flutter/material.dart';
import 'package:water_tracker/Models/person_data.dart';
import 'package:water_tracker/Utils/constants.dart';

class HomeScreenGreetingsLayout extends StatelessWidget {
  final PersonData personData = PersonData();
  final String dateTime;
  HomeScreenGreetingsLayout({super.key, required this.dateTime});

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
                "$homeScreenGreeting ${personData.getName}",
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
         Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.00),
              child: Text(
                dateTime,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
