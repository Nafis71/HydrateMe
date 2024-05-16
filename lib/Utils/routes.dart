import 'package:flutter/material.dart';
import 'package:water_tracker/Views/ViewAllDrinkScreen/view_all_drink_screen_view.dart';
import '../Views/DataCollectionScreen/data_collection_screen.dart';
import '../Views/HomeScreen/home_screen_view.dart';
import '../Views/OnboardScreen/onboard_screen_view.dart';
import '../Views/WaterReminderScreen/water_reminder_screen_view.dart';

enum Routes {
  onBoardScreen,
  homeScreen,
  dataCollectionScreen,
  addNotificationScreen,
  viewAllDrinkScreen
}

MaterialPageRoute? generateRoute(RouteSettings routeSettings) {
  final Map<String, WidgetBuilder> routes = {
    Routes.onBoardScreen.toString(): (context) => const OnboardScreenView(),
    Routes.homeScreen.toString(): (context) => const HomeScreenView(),
    Routes.dataCollectionScreen.toString(): (context) =>
        const DataCollectionScreenView(),
    Routes.addNotificationScreen.toString(): (context) =>
        const WaterReminderScreenView(),
    Routes.viewAllDrinkScreen.toString(): (context) => const ViewAllDrinkScreenView(),
  };
  final WidgetBuilder? builder = routes[routeSettings.name];
  return (builder != null) ? MaterialPageRoute(builder: builder) : null;
}
