import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:water_tracker/HiveBoxes/boxes.dart';
import 'package:water_tracker/Models/bottom_sheet_contents.dart';
import 'package:water_tracker/Models/person_data.dart';
import 'package:water_tracker/Models/water_intake_model.dart';
import 'package:water_tracker/Widgets/appbar_icon_button.dart';
import 'package:water_tracker/Widgets/home_screen_bottom_layout.dart';
import 'package:water_tracker/Widgets/home_screen_bottom_sheet.dart';
import 'package:water_tracker/Widgets/home_screen_greetings_layout.dart';
import 'package:water_tracker/Widgets/home_screen_recently_drank_info.dart';
import 'package:water_tracker/Widgets/home_screen_water_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final PersonData personData;
  late TextEditingController _drinkSizeController;
  Color bottomSheetEditBoxColor = Colors.blue;
  int drankWater = 0;
  double _selectedDrinkQuantity = 0.0;
  String selectedDrink = "";

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
                                onPressed: () {
                                  launchWaterIntakeMenu();
                                },
                              ),
                            ),
                            HomeScreenRecentlyDrankInfo(
                              screenHeight: screenHeight,
                              screenWidth: screenWidth,
                              orientation: orientation,
                              drank: drankWater,
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
      builder: (context) => HomeScreenBottomSheet(
        drinkSizeController: _drinkSizeController,
        onContainerTap: chooseContainer,
        addWaterIntake: addWaterIntake,
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
          dateTime: dateTime);
      Navigator.pop(context);
      saveToDatabase(data);
    }
  }

  Future<void> saveToDatabase(WaterIntakeModel data) async {
    Box hiveBox = Boxes.getData();
    hiveBox.add(data);
  }

  String getDateTime() {
    String dateTimeNow = DateFormat.MMMMEEEEd().format(DateTime.now());
    return dateTimeNow;
  }
}
