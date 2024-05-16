import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:water_tracker/Controllers/water_tracker_controller.dart';
import 'package:water_tracker/Views/ViewAllDrinkScreen/view_all_drink_list_layout.dart';
import 'package:water_tracker/Views/ViewAllDrinkScreen/view_all_drink_list_no_data_layout.dart';

import '../../Models/water_intake_model.dart';
import '../../Utils/colors.dart';

class ViewAllDrinkScreenView extends StatefulWidget {
  const ViewAllDrinkScreenView({super.key});

  @override
  State<ViewAllDrinkScreenView> createState() => _ViewAllDrinkScreenViewState();
}

class _ViewAllDrinkScreenViewState extends State<ViewAllDrinkScreenView> {
  late String displayedDatetimeHeader;
  late WaterTrackerController waterDrinkListController;
  @override
  void initState() {
    waterDrinkListController = WaterTrackerController(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<WaterIntakeModel> waterIntakeModel = waterDrinkListController.getAllDrinkList();
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
          : const ViewAllDrinkListNoDataLayout(),
    );
  }


}
