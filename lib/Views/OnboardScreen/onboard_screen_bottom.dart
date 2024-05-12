import 'package:flutter/material.dart';
import '../../Models/onboard_contents.dart';
import 'onboard_page_counter.dart';

class OnboardScreenBottom extends StatelessWidget {
  final int currentIndex;
  final double screenWidth, screenHeight;
  final Function changePage;
  final Orientation orientation;

  const OnboardScreenBottom(
      {super.key,
      required this.currentIndex,
      required this.screenWidth,
      required this.screenHeight,
      required this.changePage,
      required this.orientation});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenWidth,
      height: (orientation == Orientation.portrait)
          ? screenHeight * 0.1
          : screenHeight * 0.2,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  contents.length,
                  (index) => OnboardPageCounter(
                      currentIndex: currentIndex, index: index),
                ),
              ),
            ],
          ),
          Padding(
            padding: (orientation == Orientation.portrait)
                ? const EdgeInsets.symmetric(horizontal: 10.00)
                : const EdgeInsets.symmetric(horizontal: 30.00),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () => changePage(),
                  icon: const Icon(
                    Icons.navigate_next_outlined,
                    size: 40,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
