import 'package:flutter/material.dart';
import 'package:water_tracker/Enums/routes.dart';
import 'package:water_tracker/Screens/onboard_screen.dart';

main(){
  runApp(const WaterTracker());
}

class WaterTracker extends StatelessWidget {
  const WaterTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Water Tracker",
      // initialRoute: Routes.onBoardScreen.toString(),
      // onGenerateRoute: (routeSettings){
      //   generateRoute(routeSettings);
      // },
      home: OnboardScreen(),
    );
  }

  MaterialPageRoute? generateRoute(RouteSettings routeSettings){
    final Map<String,WidgetBuilder> routes = {
      Routes.onBoardScreen.toString(): (context) => const OnboardScreen()
    };
    final WidgetBuilder? builder = routes[routeSettings.name];
    return (builder != null) ? MaterialPageRoute(builder: builder) : null;
  }
}
