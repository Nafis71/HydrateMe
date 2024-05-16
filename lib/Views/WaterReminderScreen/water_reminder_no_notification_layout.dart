import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../Utils/constants.dart';

class NoNotificationLayout extends StatelessWidget {
  const NoNotificationLayout({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: screenHeight, // Adjust this as needed
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            width: screenWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: screenHeight * 0.1,
                ),
                SvgPicture.asset(
                  noNotificationFoundImage,
                  height: screenHeight * 0.5,
                  fit: BoxFit.contain,
                ),
                const Text(
                  noNotificationFoundText,
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
