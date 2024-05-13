import 'package:flutter/material.dart';

import '../../Themes/appbar_themes.dart';
import '../../Themes/elevated_button_style.dart';
import '../../Themes/form_text_field_themes.dart';
import '../../Utils/routes.dart';

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