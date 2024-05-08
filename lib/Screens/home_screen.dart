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
      appBar: AppBar(
        title: const Text("HydrateMe"),
        actions: const [
          AppBarIconButton(desiredIcon: Icons.notifications_none),
          AppBarIconButton(desiredIcon: Icons.history),
        ],
      ),
      body: SafeArea(
        child: OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.00),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 6,
                    child: SizedBox(
                      height: screenHeight * 0.92,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 2,
                            ),
                            const HomeScreenGreetingsLayout(),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: screenHeight * 0.43,
                              child: HomeScreenWaterIndicator(
                                screenHeight: screenHeight,
                                screenWidth: screenWidth,
                              ),
                            ),
                            HomeScreenRecentlyDrankInfo(
                              screenHeight: screenHeight,
                              screenWidth: screenWidth,
                              orientation: orientation,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  HomeScreenBottomLayout(
                    screenHeight: screenHeight,
                    screenWidth: screenWidth,
                    orientation: orientation,
                  ),
                  const SizedBox(
                    height: 5,
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
