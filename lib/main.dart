import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'Models/notification_register_model.dart';
import 'Models/water_intake_model.dart';
import 'Views/App/app.dart';
import 'package:device_preview_minus/device_preview_minus.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(WaterIntakeModelAdapter());
  Hive.registerAdapter(NotificationRegisterModelAdapter());
  await Hive.openBox<WaterIntakeModel>("WaterIntake");
  await Hive.openBox<NotificationRegisterModel>("NotificationRecord");
  runApp(const WaterTracker());
}
