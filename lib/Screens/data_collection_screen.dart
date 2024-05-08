import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:water_tracker/Widgets/app_radio_list_tile.dart';
import 'package:water_tracker/Widgets/text_form_field.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class DataCollectionScreen extends StatefulWidget {
  const DataCollectionScreen({super.key});

  @override
  State<DataCollectionScreen> createState() => _DataCollectionScreenState();
}

class _DataCollectionScreenState extends State<DataCollectionScreen> {
  late final GlobalKey<FormState> formKey;
  List<String> genderRadioOptions = ["Male", "Female"];
  late TextEditingController _nameController;
  late TextEditingController _ageController;
  String gender = "Male";
  bool isAllGood = false;

  @override
  void initState() {
    _nameController = TextEditingController();
    _ageController = TextEditingController();
    formKey = GlobalKey<FormState>();
    super.initState();
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
                              "assets/images/info.svg",
                              fit: BoxFit.contain,
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
                      title: const Text("We need some of your data"),
                      titleTextStyle: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      subtitle:
                          const Text("To tailor the app according to you"),
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
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          FormTextField(
                            controller: _nameController,
                            hintText: "Enter your name",
                            errorText: "Invalid Name",
                            regExpression: r'^[a-z A-Z]+$',
                            textInputType: TextInputType.text,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          FormTextField(
                            controller: _ageController,
                            hintText: "Enter your age",
                            errorText: "Invalid Age",
                            regExpression: r'^[0-9]+$',
                            textInputType: TextInputType.number,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          AppRadioListTile(
                            gender: gender,
                            genderRadioOption: genderRadioOptions[0],
                            onChanged: (value) {
                              gender = value.toString();
                              setState(() {});
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          AppRadioListTile(
                            gender: gender,
                            genderRadioOption: genderRadioOptions[1],
                            onChanged: (value) {
                              gender = value.toString();
                              setState(() {});
                            },
                          ),
                          (orientation == Orientation.landscape)
                              ? const SizedBox(
                                  height: 40,
                                )
                              : const SizedBox(
                                  height: 70,
                                ),
                          SizedBox(
                            width: screenWidth * 0.9,
                            height: (orientation == Orientation.portrait)
                                ? screenHeight * 0.07
                                : screenHeight * 0.15,
                            child: ElevatedButton(
                              onPressed: () {},
                              // TODO I have to move this portion to the themeData
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF2AA2D6),
                                  foregroundColor: Colors.white,
                                  elevation: 8,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15))),
                              child: const Text(
                                "Continue",
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
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
