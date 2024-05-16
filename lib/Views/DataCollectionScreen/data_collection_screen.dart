import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:water_tracker/Controllers/data_collection_controller.dart';
import 'package:water_tracker/Utils/routes.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';
import '../../Utils/constants.dart';
import 'data_collection_screen_form_layout.dart';

class DataCollectionScreenView extends StatefulWidget {
  const DataCollectionScreenView({super.key});

  @override
  State<DataCollectionScreenView> createState() =>
      _DataCollectionScreenViewState();
}

class _DataCollectionScreenViewState extends State<DataCollectionScreenView> {
  late final DataCollectionController dataCollectionController;
  late final GlobalKey<FormState> formKey;
  List<String> genderRadioOptions = ["Male", "Female"];
  late TextEditingController _nameController;
  late TextEditingController _ageController;
  String gender = "Male";
  bool isAllGood = false;

  @override
  void initState() {
    initializeSharedPreference();
    _nameController = TextEditingController();
    _ageController = TextEditingController();
    formKey = GlobalKey<FormState>();
    super.initState();
  }

  Future<void> initializeSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    dataCollectionController = DataCollectionController(preferences);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.00),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        WidgetAnimator(
                          incomingEffect:
                              WidgetTransitionEffects.incomingSlideInFromBottom(
                                  duration: const Duration(milliseconds: 1500)),
                          atRestEffect:
                              WidgetRestingEffects.bounce(numberOfPlays: 2),
                          child: SizedBox(
                            height: screenHeight * 0.25,
                            width: screenWidth * 0.8,
                            child: SvgPicture.asset(
                              personalInformationImage,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                      ],
                    ),
                    ListTile(
                      tileColor: Colors.blue[50],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.00),
                      ),
                      title: const Text(personalInformationAskingHeader),
                      titleTextStyle: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      subtitle:
                          const Text(personalInformationAskingSubtitle),
                      subtitleTextStyle:
                          const TextStyle(fontSize: 13, color: Colors.grey),
                      leading: const Icon(
                        Icons.info,
                        color: Color(0xFF2AA2D6),
                        size: 34,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    DataCollectionScreenFormLayout(
                      orientation: orientation,
                      nameController: _nameController,
                      ageController: _ageController,
                      formKey: formKey,
                      gender: gender,
                      genderRadioOptions: genderRadioOptions,
                      screenWidth: screenWidth,
                      screenHeight: screenHeight,
                      onChanged: (value) {
                        gender = value.toString();
                        setState(() {});
                      },
                    ),
                    SizedBox(
                      width: screenWidth * 0.9,
                      height: (orientation == Orientation.portrait)
                          ? screenHeight * 0.07
                          : screenHeight * 0.15,
                      child: ElevatedButton(
                        onPressed: () {
                          checkUserData();
                        },
                        child: const Text(
                          continueButtonText,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void checkUserData() {
    if (formKey.currentState!.validate()) {
      saveData();
      return;
    }
  }

  void saveData() {
    dataCollectionController.saveData(
        _nameController.text, _ageController.text, gender);
    gotoHomeScreen();
  }

  void gotoHomeScreen() {
    loadingScreen();
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.of(context).pop();
        Navigator.pushReplacementNamed(context, Routes.homeScreen.toString());
      },
    );
  }

  Future loadingScreen() async {
    showDialog(
      context: context,
      barrierColor: Colors.white30,
      builder: (context) {
        return Center(
          child: Lottie.asset(loadingAnimationLottie),
        );
      },
    );
  }
}
