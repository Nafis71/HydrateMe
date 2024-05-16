import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:water_tracker/Utils/app_scroll_behaviour.dart';
import 'package:water_tracker/Utils/colors.dart';
import '../../Services/notification_service.dart';
import '../../Themes/appbar_themes.dart';
import '../../Themes/elevated_button_style.dart';
import '../../Themes/form_text_field_themes.dart';
import '../../Utils/routes.dart';
import 'package:device_preview_minus/device_preview_minus.dart';

class WaterTracker extends StatefulWidget {
  const WaterTracker({
    super.key,
  });

  @override
  State<WaterTracker> createState() => _WaterTrackerState();
}

class _WaterTrackerState extends State<WaterTracker> {
  @override
  void initState() {
    NotificationService.initializeNotification();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Water Tracker",
      debugShowCheckedModeBanner: false,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      initialRoute: Routes.onBoardScreen.toString(),
      onGenerateRoute: (routeSettings) => generateRoute(routeSettings),
      theme: ThemeData(
        appBarTheme: AppbarTheme.getAppbarTheme(),
        scaffoldBackgroundColor: Colors.white,
        primaryColor: appPrimaryColor,
        inputDecorationTheme: FormTextFieldThemes.getFormTextFieldDecoration(),
        elevatedButtonTheme: ElevatedButtonStyle.getElevatedButtonStyle(),
      ),
      scrollBehavior: AppScrollBehaviour(),
    );
  }
}