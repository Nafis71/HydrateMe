import 'package:flutter/material.dart';
import 'package:water_tracker/Widgets/appbar_icon_button.dart';
import 'package:water_tracker/Widgets/home_screen_bottom_layout.dart';
import 'package:water_tracker/Widgets/home_screen_greetings_layout.dart';
import 'package:water_tracker/Widgets/home_screen_recently_drank_info.dart';
import 'package:water_tracker/Widgets/home_screen_water_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("HydrateMe"),
        actions: const [
          AppBarIconButton(desiredIcon: Icons.notifications_none),
          AppBarIconButton(desiredIcon: Icons.history),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.00),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const HomeScreenGreetingsLayout(),
                    const SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      height: screenHeight * 0.45,
                      child: HomeScreenWaterIndicator(
                        screenHeight: screenHeight,
                        screenWidth: screenWidth,
                      ),
                    ),
                    HomeScreenRecentlyDrankInfo(
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                    ),
                  ],
                ),
              ),
            ),
            HomeScreenBottomLayout(
              screenHeight: screenHeight,
              screenWidth: screenWidth,
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
