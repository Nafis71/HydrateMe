import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'Models/water_intake_model.dart';
import 'Views/App/app.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(WaterIntakeModelAdapter());
  await Hive.openBox<WaterIntakeModel>("WaterIntake");
  runApp(const WaterTracker());
}
