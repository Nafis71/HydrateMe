import 'package:flutter/material.dart';
import 'package:water_tracker/Enums/routes.dart';
import 'package:water_tracker/Screens/home_screen.dart';
import 'package:water_tracker/Screens/onboard_screen.dart';
import 'package:water_tracker/Themes/appbar_themes.dart';

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
      ),
    );
  }

  MaterialPageRoute? generateRoute(RouteSettings routeSettings) {
    final Map<String, WidgetBuilder> routes = {
      Routes.onBoardScreen.toString(): (context) => const OnboardScreen(),
      Routes.homeScreen.toString(): (context) => const HomeScreen()
    };
    final WidgetBuilder? builder = routes[routeSettings.name];
    return (builder != null) ? MaterialPageRoute(builder: builder) : null;
  }
}
