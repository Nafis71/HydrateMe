import 'package:hive/hive.dart';

import '../Models/water_intake_model.dart';

class Boxes{
  static Box<WaterIntakeModel> getData() => Hive.box("WaterIntake");
}