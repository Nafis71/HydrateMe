import 'package:flutter/material.dart';

import '../../Models/onboard_contents.dart';
import 'onboard_screen_bottom.dart';
import 'onboard_screen_landscape.dart';
import 'onboard_screen_portrait.dart';

class OnboardScreenLayout extends StatelessWidget {
  final double screenHeight, screenWidth;
  final PageController _pageController;
  final Function(dynamic) onPageChanged;
  final Orientation orientation;
  final int currentIndex;
  final Function changePage;

  const OnboardScreenLayout(this._pageController,
      {super.key,
      required this.screenHeight,
      required this.screenWidth,
      required this.onPageChanged,
      required this.orientation,
      required this.currentIndex,
      required this.changePage});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          flex: 1,
          child: SizedBox(
            height: screenHeight,
            width: screenWidth,
            child: PageView.builder(
              controller: _pageController,
              itemCount: contents.length,
              onPageChanged: onPageChanged,
              itemBuilder: (_, index) => (orientation == Orientation.portrait)
                  ? OnboardScreenPortrait(
                      screenWidth: screenWidth,
                      screenHeight: screenHeight,
                      index: index)
                  : OnboardScreenLandscape(
                      screenWidth: screenWidth,
                      screenHeight: screenHeight,
                      index: index),
            ),
          ),
        ),
        OnboardScreenBottom(
          currentIndex: currentIndex,
          screenWidth: screenWidth,
          screenHeight: screenHeight,
          changePage: changePage,
          orientation: orientation,
        )
      ],
    );
  }
}
