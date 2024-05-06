import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../Models/onboard_contents.dart';

class OnboardScreenLandscape extends StatelessWidget {
  final int index;
  final double screenHeight, screenWidth;

  const OnboardScreenLandscape({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.index,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.00),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: screenWidth * 0.3,
                height: screenHeight * 0.6,
                child: SvgPicture.asset(
                  contents[index].image,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                height: 10.00,
              ),
              SizedBox(
                width: screenWidth * 0.5,
                child: Wrap(
                  alignment: WrapAlignment.start,
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
          )
        ],
      ),
    );
  }
}
