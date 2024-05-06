import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:water_tracker/Models/onboard_contents.dart';
import 'package:water_tracker/Widgets/onboard_screen_bottom.dart';
import 'package:water_tracker/Widgets/onboard_screen_landscape.dart';
import 'package:water_tracker/Widgets/onboard_screen_portrait_layout.dart';

import '../Widgets/onboard_page_counter.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  int currentIndex = 0;

  late PageController _pageController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    late double screenHeight, screenWidth;
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          _pageController = PageController(initialPage: currentIndex);
          if (orientation == Orientation.portrait) {
            return portraitMode(screenHeight, screenWidth, orientation);
          }
          return landscapeMode(screenHeight, screenWidth, orientation);
        },
      ),
    );
  }

  Widget portraitMode(
      double screenHeight, screenWidth, Orientation orientation) {
    print(currentIndex);
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          flex: 1,
          child: SizedBox(
            height: screenHeight,
            child: PageView.builder(
              controller: _pageController,
              itemCount: contents.length,
              onPageChanged: (index) => setState(() => currentIndex = index),
              itemBuilder: (_, index) => OnboardPortrait(
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

  Widget landscapeMode(
      double screenHeight, double screenWidth, Orientation orientation) {
    return Column(
      children: [
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                width: screenWidth,
                height: screenHeight,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: contents.length,
                  onPageChanged: (index) =>
                      setState(() => currentIndex = index),
                  itemBuilder: (_, index) => OnboardLandscape(
                      screenWidth: screenWidth,
                      screenHeight: screenHeight,
                      index: index),
                ),
              ),
            ],
          ),
        ),
        OnboardScreenBottom(
            currentIndex: currentIndex,
            screenWidth: screenWidth,
            screenHeight: screenHeight,
            changePage: changePage,
            orientation: orientation),
      ],
    );
  }

  void changePage() {
    if (currentIndex == contents.length - 1) {}
    _pageController.nextPage(
        duration: const Duration(milliseconds: 600), curve: Curves.easeIn);
  }
}
