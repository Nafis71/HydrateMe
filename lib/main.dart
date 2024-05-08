import 'package:flutter/material.dart';
import 'package:water_tracker/Enums/routes.dart';
import 'package:water_tracker/Screens/data_collection_screen.dart';
import 'package:water_tracker/Screens/home_screen.dart';
import 'package:water_tracker/Screens/onboard_screen.dart';
import 'package:water_tracker/Themes/appbar_themes.dart';
import 'package:water_tracker/Themes/form_text_field_themes.dart';

main() {
  runApp(const WaterTracker());
}

class WaterTracker extends StatelessWidget {
  const WaterTracker({super.key});

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
      ),
    );
  }

  MaterialPageRoute? generateRoute(RouteSettings routeSettings) {
    final Map<String, WidgetBuilder> routes = {
      Routes.onBoardScreen.toString(): (context) => const OnboardScreen(),
      Routes.homeScreen.toString(): (context) => const HomeScreen(),
      Routes.dataCollectionScreen.toString() : (context) => const DataCollectionScreen()
    };
    final WidgetBuilder? builder = routes[routeSettings.name];
    return (builder != null) ? MaterialPageRoute(builder: builder) : null;
  }
}
