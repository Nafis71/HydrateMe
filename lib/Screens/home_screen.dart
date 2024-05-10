import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:water_tracker/Models/bottom_sheet_contents.dart';
import 'package:water_tracker/Models/person_data.dart';
import 'package:water_tracker/Widgets/appbar_icon_button.dart';
import 'package:water_tracker/Widgets/bottom_sheet_container.dart';
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
    debugPrint(_selectedDrinkQuantity.toString());
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
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              margin: const EdgeInsets.all(10.00),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Wrap(
                      children: [
                        Text(
                          "Choose drink type",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Wrap(
                      children: [
                        Text(
                          "Select what you actually drink",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.27,
                      child: GridView.builder(
                        itemCount: containerContents.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          childAspectRatio: 1.7,
                          mainAxisSpacing: 10,
                        ),
                        itemBuilder: (context, index) => InkWell(
                          onTap: () {},
                          child: InkWell(
                            splashColor: Colors.transparent,
                            onTap: () {
                              chooseContainer(index);
                              setState(() {});
                              setModalState(() {});
                            },
                            child: BottomSheetContainer(
                              backgroundColor:
                                  containerContents[index].backgroundColor,
                              borderColor: containerContents[index].borderColor,
                              cardHeader: containerContents[index].header,
                              icon: containerContents[index].icon,
                              index: index,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _drinkSizeController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelStyle: TextStyle(
                              color: bottomSheetEditBoxColor, fontSize: 16),
                          labelText: "Enter size of the drink",
                          hintFadeDuration: const Duration(seconds: 1),
                          hintText: "Enter size of the drink",
                          contentPadding: const EdgeInsets.all(15.00),
                          suffix: const Text("ml"),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(30),
                                  topRight: Radius.circular(30)),
                              borderSide:
                                  BorderSide(color: bottomSheetEditBoxColor))),
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.06,
                        child: ElevatedButton(
                            onPressed: () {}, child: Text("ADD DRINK")))
                  ],
                ),
              ),
            ),
          ),
        ),
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
  }
}
