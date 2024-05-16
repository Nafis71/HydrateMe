import 'package:flutter/material.dart';
import '../Models/water_intake_model.dart';

IconData? getIcon(List<WaterIntakeModel> waterIntakeModel, int index) {
  Map<String, IconData> iconMap = {
    "Coffee": Icons.coffee,
    "Water": Icons.water_drop,
    "Juice": Icons.apple,
    "Tea": Icons.energy_savings_leaf,
  };
  return iconMap[waterIntakeModel[index].drinkName];
}