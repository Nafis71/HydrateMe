import 'package:hive/hive.dart';

import '../Models/water_intake_model.dart';

class HiveBoxes{
  static Box<WaterIntakeModel> getData() => Hive.box("WaterIntake");
}