import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  late TextEditingController _drinkSizeController;
  Color bottomSheetEditBoxColor = Colors.blue;
  int goalCompletion = 0;
  double _selectedDrinkQuantity = 0.0;
  String selectedDrink = "";
  IconData selectedDrinkIcon = Icons.water_drop;

  @override
  void initState() {
    _drinkSizeController = TextEditingController();
    personData = PersonData();
    initializeSharedPreference();
    super.initState();
  }

  @override
  void dispose() {
    _drinkSizeController.dispose();
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
    int drankWater = calculateDailyWaterIntake();
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
          AppBarIconButton(
            desiredIcon: Icons.history,
            onPressed: () {},
          ),
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
                            HomeScreenGreetingsLayout(
                              dateTime: getDateTime(),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: screenHeight * 0.43,
                              child: HomeScreenWaterIndicator(
                                screenHeight: screenHeight,
                                screenWidth: screenWidth,
                                goalCompletion: goalCompletion,
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
            drinkSizeController: _drinkSizeController,
            onContainerTap: chooseContainer,
            addWaterIntake: addWaterIntake,
          );
        },
      ),
    );
  }

  void chooseContainer(int index) {
    containerContents[index].isSelected = !containerContents[index].isSelected;
    if (containerContents[index].isSelected) {
      selectedDrink = containerContents[index].header;
      bottomSheetEditBoxColor = containerContents[index].borderColor;
    } else {
      selectedDrink = "";
    }
    int id = containerContents[index].id;
    int length = containerContents.length;
    for (int i = 0; i < length; i++) {
      if (id != containerContents[i].id) {
        containerContents[i].isSelected = false;
      }
    }
    setState(() {});
  }

  void addWaterIntake(BuildContext context) async {
    _selectedDrinkQuantity = double.tryParse(_drinkSizeController.text) ?? 0.0;
    if (selectedDrink != "" && _selectedDrinkQuantity > 0) {
      DateTime dateTime = DateTime.now();
      final data = WaterIntakeModel(
        drinkName: selectedDrink,
        drinkSize: _selectedDrinkQuantity.toInt().toString(),
        dateTime: dateTime,
      );
      Navigator.pop(context);
      saveToDatabase(data);
    }
  }

  void saveToDatabase(WaterIntakeModel data) {
    Box hiveBox = HiveBoxes.getWaterIntakeData();
    hiveBox.add(data);
    setState(() {});
  }

  String getDateTime() {
    String dateTimeNow = DateFormat.MMMMEEEEd().format(DateTime.now());
    return dateTimeNow;
  }

  int calculateDailyWaterIntake() {
    int totalDrank = 0;
    Box hiveBox = HiveBoxes.getWaterIntakeData();
    String dateOfToday = DateFormat.yMMMd().format(DateTime.now());
    for (int index = 0; index < hiveBox.length; index++) {
      if (DateFormat.yMMMd().format(hiveBox.get(index).dateTime) ==
          dateOfToday) {
        totalDrank += int.tryParse(hiveBox.get(index).drinkSize) ?? 0;
      }
    }
    goalCompletion =
        ((totalDrank / personData.calculateWaterIntakeGoal()) * 100).toInt();
    return totalDrank;
  }
}
