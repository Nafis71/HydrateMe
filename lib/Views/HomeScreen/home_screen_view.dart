import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:water_tracker/Controllers/water_tracker_controller.dart';
import 'package:water_tracker/Models/water_intake_tracker_model.dart';
import 'package:water_tracker/Utils/hive_boxes.dart';
import 'package:water_tracker/Models/bottom_sheet_contents.dart';
import 'package:water_tracker/Models/person_data.dart';
import 'package:water_tracker/Models/water_intake_model.dart';
import 'package:water_tracker/Utils/routes.dart';
import 'package:water_tracker/Views/HomeScreen/home_screen_bottom_layout.dart';
import 'package:water_tracker/Views/HomeScreen/home_screen_bottom_sheet.dart';
import 'package:water_tracker/Views/HomeScreen/home_screen_recently_drank_info.dart';
import '../Components/appbar_icon_button.dart';
import 'home_screen_greetings_layout.dart';
import 'home_screen_water_indicator.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  late final PersonData personData;
  late TextEditingController _drinkSizeTEController;
  late WaterTrackerController waterDrinkListController;
  late WaterIntakeTrackerModel waterIntakeTrackerModel;
  Color bottomSheetEditBoxColor = Colors.blue;
  IconData selectedDrinkIcon = Icons.water_drop;

  @override
  void initState() {
    _drinkSizeTEController = TextEditingController();
    waterDrinkListController = WaterTrackerController(context);
    waterIntakeTrackerModel = WaterIntakeTrackerModel.getInstance();
    personData = PersonData();
    initializeSharedPreference();
    super.initState();
  }

  @override
  void dispose() {
    _drinkSizeTEController.dispose();
    super.dispose();
  }

  void initializeSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    personData.personName = preferences.getString("userName")!;
    personData.personGender = preferences.getString("userGender")!;
    personData.personAge = int.tryParse(preferences.getString("userAge")!) ?? 0;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    int drankWater =
        waterDrinkListController.calculateDailyWaterIntake(
            waterIntakeTrackerModel, personData);
    return Scaffold(
      appBar: AppBar(
        title: const Text("HydrateMe"),
        actions: [
          AppBarIconButton(
            desiredIcon: Icons.notification_add,
            onPressed: () {
              Navigator.pushNamed(
                  context, Routes.addNotificationScreen.toString());
            },
          ),
        ],
        centerTitle: false,
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
                            HomeScreenGreetingsLayout(
                              dateTime:
                                  DateFormat.MMMMEEEEd().format(DateTime.now()),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: screenHeight * 0.43,
                              child: HomeScreenWaterIndicator(
                                screenHeight: screenHeight,
                                screenWidth: screenWidth,
                                goalCompletion:
                                    waterIntakeTrackerModel.goalCompletion,
                                onPressed: () {
                                  launchWaterIntakeMenu();
                                },
                              ),
                            ),
                            HomeScreenRecentlyDrankInfo(
                              screenHeight: screenHeight,
                              screenWidth: screenWidth,
                              orientation: orientation,
                              drankWater: drankWater,
                              waterDrinkListController:
                                  waterDrinkListController,
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
                    drankWater: drankWater,
                    personData: personData,
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

  void launchWaterIntakeMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) => OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          return HomeScreenBottomSheet(
            orientation: orientation,
            drinkSizeController: _drinkSizeTEController,
            onContainerTap: (index) {
              waterDrinkListController.chooseContainer(
                  index,
                  waterIntakeTrackerModel.selectedDrink,
                  bottomSheetEditBoxColor,
                  waterIntakeTrackerModel);
              setState(() {});
            },
            addWaterIntake: (context) {
              waterDrinkListController.addWaterIntake(
                  context, waterIntakeTrackerModel, _drinkSizeTEController);
              setState(() {});
            },
          );
        },
      ),
    );
  }
}
