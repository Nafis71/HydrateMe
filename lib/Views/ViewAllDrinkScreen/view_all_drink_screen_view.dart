import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:water_tracker/Views/ViewAllDrinkScreen/view_all_drink_list_layout.dart';
import 'package:water_tracker/Views/ViewAllDrinkScreen/view_all_screen_no_data_layout.dart';

import '../../Models/water_intake_model.dart';
import '../../Utils/colors.dart';
import '../../Utils/constants.dart';
import '../../Utils/hive_boxes.dart';

class ViewAllDrinkScreenView extends StatefulWidget {
  const ViewAllDrinkScreenView({super.key});

  @override
  State<ViewAllDrinkScreenView> createState() => _ViewAllDrinkScreenViewState();
}

class _ViewAllDrinkScreenViewState extends State<ViewAllDrinkScreenView> {
  late String displayedDatetimeHeader;

  @override
  Widget build(BuildContext context) {
    List<WaterIntakeModel> waterIntakeModel = getAllDrinkList();
    if (waterIntakeModel.isNotEmpty) {
      displayedDatetimeHeader =
          DateFormat.MMMMEEEEd().format(waterIntakeModel[0].dateTime);
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("View All Drinks"),
        leading: IconButton(
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: appPrimaryColor,
            size: 27,
          ),
        ),
      ),
      body: (waterIntakeModel.isNotEmpty)
          ? ViewAllDrinkListLayout(
              displayedDatetimeHeader: displayedDatetimeHeader,
              waterIntakeModel: waterIntakeModel,
            )
          : const ViewAllScreenNoDataLayout(),
    );
  }

  List<WaterIntakeModel> getAllDrinkList() {
    List<WaterIntakeModel> models = [];
    Box hiveBox = HiveBoxes.getWaterIntakeData();
    int length = hiveBox.length;
    debugPrint(length.toString());
    for (int index = length - 1; index >= 0; index--) {
      models.add(hiveBox.getAt(index));
    }
    return models;
  }
}
