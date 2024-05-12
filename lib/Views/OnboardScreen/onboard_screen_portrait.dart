import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../Models/onboard_contents.dart';

class OnboardScreenPortrait extends StatelessWidget {
  final int index;
  final double screenHeight, screenWidth;

  const OnboardScreenPortrait({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.00),
      child: Column(
        children: [
          const SizedBox(
            height: 120,
          ),
          SizedBox(
            width: screenWidth * 0.8,
            height: screenHeight * 0.28,
            child: SvgPicture.asset(
              contents[index].image,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Wrap(
            alignment: WrapAlignment.center,
            children: [
              Text(
                contents[index].title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(10.00),
            child: Wrap(
              alignment: WrapAlignment.center,
              children: [
                Text(
                  contents[index].description,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
