import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:water_tracker/Models/person_data.dart';
import 'package:water_tracker/Widgets/appbar_icon_button.dart';
import 'package:water_tracker/Widgets/home_screen_bottom_layout.dart';
import 'package:water_tracker/Widgets/home_screen_greetings_layout.dart';
import 'package:water_tracker/Widgets/home_screen_recently_drank_info.dart';
import 'package:water_tracker/Widgets/home_screen_water_indicator.dart';

late final SharedPreferences preferences;

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key, required SharedPreferences sharedPreferences}) {
    preferences = sharedPreferences;
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final PersonData personData;

  @override
  void initState() {
    personData = PersonData();
    initializeSharedPreference();
    super.initState();
  }

  void initializeSharedPreference() {
    personData.personName = preferences.getString("userName")!;
    personData.personGender = preferences.getString("userGender")!;
    personData.personAge = int.tryParse(preferences.getString("userAge")!) ?? 0;
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
                            HomeScreenGreetingsLayout(),
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
