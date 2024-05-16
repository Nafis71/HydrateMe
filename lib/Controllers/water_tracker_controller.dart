import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:water_tracker/Models/person_data.dart';
import 'package:water_tracker/Models/water_intake_tracker_model.dart';

import '../Models/bottom_sheet_contents.dart';
import '../Models/water_intake_model.dart';
import '../Utils/hive_boxes.dart';

class WaterTrackerController {
  BuildContext context;

  WaterTrackerController(this.context);

  List<WaterIntakeModel> getAllDrinkList() {
    List<WaterIntakeModel> models = [];
    Box hiveBox = HiveBoxes.getWaterIntakeData();
    int length = hiveBox.length;
    for (int index = length - 1; index >= 0; index--) {
      models.add(hiveBox.getAt(index));
    }
    return models;
  }

  List<WaterIntakeModel> getRecentDrinkInfo(int maxItem) {
    List<WaterIntakeModel> models = [];
    Box hiveBox = HiveBoxes.getWaterIntakeData();
    int length = hiveBox.length;
    if (length >= maxItem) {
      for (int index = length - 1; index > length - 4; index--) {
        models.add(hiveBox.getAt(index));
      }
    } else {
      for (int index = length - 1; index >= 0; index--) {
        models.add(hiveBox.getAt(index));
      }
    }
    return models;
  }

  void chooseContainer(
      int index, String selectedDrink, Color bottomSheetEditBoxColor, WaterIntakeTrackerModel waterIntakeTrackerModel) {
    containerContents[index].isSelected = !containerContents[index].isSelected;
    if (containerContents[index].isSelected) {
      waterIntakeTrackerModel.selectedDrink = containerContents[index].header;
      bottomSheetEditBoxColor = containerContents[index].borderColor;
    } else {
      waterIntakeTrackerModel.selectedDrink = "";
    }
    int id = containerContents[index].id;
    int length = containerContents.length;
    for (int i = 0; i < length; i++) {
      if (id != containerContents[i].id) {
        containerContents[i].isSelected = false;
      }
    }
  }

  int calculateDailyWaterIntake(WaterIntakeTrackerModel waterIntakeTrackerModel, PersonData personData) {
    int totalDrank = 0;
    Box hiveBox = HiveBoxes.getWaterIntakeData();
    String dateOfToday = DateFormat.yMMMd().format(DateTime.now());
    for (int index = 0; index < hiveBox.length; index++) {
      if (DateFormat.yMMMd().format(hiveBox.getAt(index).dateTime) ==
          dateOfToday) {
        totalDrank += int.tryParse(hiveBox.getAt(index).drinkSize) ?? 0;
      }
    }
    waterIntakeTrackerModel.goalCompletion =
        ((totalDrank / personData.calculateWaterIntakeGoal()) * 100).toInt();
    if(waterIntakeTrackerModel.goalCompletion > 100){
      waterIntakeTrackerModel.goalCompletion = 100;
    }
    return totalDrank;
  }

  void addWaterIntake(BuildContext context,WaterIntakeTrackerModel waterIntakeTrackerModel, TextEditingController drinkSizeTEController){
    waterIntakeTrackerModel.selectedDrinkQuantity =
        double.tryParse(drinkSizeTEController.text) ?? 0.0;
    if (waterIntakeTrackerModel.selectedDrink != "" && waterIntakeTrackerModel.selectedDrinkQuantity > 0) {
      DateTime dateTime = DateTime.now();
      final data = WaterIntakeModel(
        drinkName: waterIntakeTrackerModel.selectedDrink,
        drinkSize: waterIntakeTrackerModel.selectedDrinkQuantity.toInt().toString(),
        dateTime: dateTime,
      );
      Navigator.pop(context);
      saveToDatabase(data);
    }
  }

  void saveToDatabase(WaterIntakeModel data) {
    Box hiveBox = HiveBoxes.getWaterIntakeData();
    hiveBox.add(data);
  }
}
