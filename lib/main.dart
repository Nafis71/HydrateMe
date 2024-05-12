import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:water_tracker/Themes/appbar_themes.dart';
import 'package:water_tracker/Themes/elevated_button_style.dart';
import 'package:water_tracker/Themes/form_text_field_themes.dart';
import 'package:water_tracker/Utils/routes.dart';
import 'Models/water_intake_model.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(WaterIntakeModelAdapter());
  await Hive.openBox<WaterIntakeModel>("WaterIntake");
  runApp(const WaterTracker());
}

class WaterTracker extends StatelessWidget {
  const WaterTracker({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Water Tracker",
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.onBoardScreen.toString(),
      onGenerateRoute: (routeSettings) => generateRoute(routeSettings),
      theme: ThemeData(
        appBarTheme: AppbarTheme.getAppbarTheme(),
        scaffoldBackgroundColor: Colors.white,
        primaryColor: const Color(0xFF2AA2D6),
        inputDecorationTheme: FormTextFieldThemes.getFormTextFieldDecoration(),
        elevatedButtonTheme: ElevatedButtonStyle.getElevatedButtonStyle(),
      ),
    );
  }
}
