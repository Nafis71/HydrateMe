import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:water_tracker/Enums/routes.dart';
import 'package:water_tracker/Models/onboard_contents.dart';
import 'package:water_tracker/Models/water_intake_model.dart';
import 'package:water_tracker/Widgets/onboard_screen_layout.dart';

class OnboardScreen extends StatefulWidget {

  const OnboardScreen({super.key,});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  int currentIndex = 0;

  late PageController _pageController;

  @override
  void initState() {
    initializeSharedPreference();
    _pageController = PageController(initialPage: currentIndex);
    super.initState();
  }

  initializeHive() async{
    Hive.registerAdapter(WaterIntakeModelAdapter());
    await Hive.openBox<WaterIntakeModel>("WaterIntake");
  }

  void initializeSharedPreference() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool? isRegistered = preferences.getBool("hasRegistered");
    if (isRegistered != null) {
      skipScreen(preferences);
    }
    initializeHive();
  }

  void skipScreen(SharedPreferences preferences) {
    Navigator.pushReplacementNamed(context, Routes.homeScreen.toString(),
        arguments: preferences);
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
          return OnboardScreenLayout(
            _pageController,
            screenHeight: screenHeight,
            screenWidth: screenWidth,
            onPageChanged: (index) => setState(() => currentIndex = index),
            orientation: orientation,
            currentIndex: currentIndex,
            changePage: changePage,
          );
        },
      ),
    );
  }

  void changePage() {
    if (currentIndex == contents.length - 1) {
      Navigator.pushReplacementNamed(
          context, Routes.dataCollectionScreen.toString());
    }
    _pageController.nextPage(
        duration: const Duration(milliseconds: 600), curve: Curves.easeIn);
  }
}
