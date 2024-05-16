import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:water_tracker/Controllers/water_tracker_controller.dart';
import 'package:water_tracker/Utils/hive_boxes.dart';
import 'package:water_tracker/Models/water_intake_model.dart';
import 'package:water_tracker/Utils/routes.dart';

import '../../Utils/colors.dart';
import '../../Utils/constants.dart';
import '../../Utils/water_list_icons.dart';

class HomeScreenRecentlyDrankInfo extends StatelessWidget {
  final double screenWidth, screenHeight;
  final Orientation orientation;
  final int drankWater;
  final WaterTrackerController waterDrinkListController;
  static const int maxItem = 3;

  const HomeScreenRecentlyDrankInfo({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.orientation,
    required this.drankWater,
    required this.waterDrinkListController,
  });

  @override
  Widget build(BuildContext context) {
    List<WaterIntakeModel> waterIntakeModel =
        waterDrinkListController.getRecentDrinkInfo(maxItem);
    return SizedBox(
      width: screenWidth * 0.9,
      height: (orientation == Orientation.portrait)
          ? screenHeight * 0.25
          : screenHeight * 0.35,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                recentlyDrankText,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  Navigator.pushNamed(
                      context, Routes.viewAllDrinkScreen.toString());
                },
                child: const Text(
                  viewAllText,
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          Divider(
            color: Colors.grey[100],
          ),
          const SizedBox(
            height: 5,
          ),
          (drankWater != 0)
              ? recentlyDrankWaterLayout(waterIntakeModel)
              : noRecordLayout(),
        ],
      ),
    );
  }

  Widget recentlyDrankWaterLayout(List<WaterIntakeModel> waterIntakeModel) =>
      Flexible(
        child: Material(
          color: Colors.white,
          child: ListView.separated(
            itemCount: waterIntakeModel.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  waterIntakeModel[index].drinkName,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w600),
                ),
                tileColor: lightBlue,
                leading: Icon(
                  getIcon(waterIntakeModel, index),
                  size: 28,
                ),
                subtitle:
                    Text("${waterIntakeModel[index].drinkSize}$sizeMetric"),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      DateFormat.MMMMEEEEd()
                          .format(waterIntakeModel[index].dateTime),
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      DateFormat.jm().format(waterIntakeModel[index].dateTime),
                      style: const TextStyle(
                        color: deepGray,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.00),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                height: 10,
              );
            },
          ),
        ),
      );

  Widget noRecordLayout() => ListTile(
        title: const Text(
          noRecordOfWaterConsumptionText,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
        tileColor: lightBlue,
        leading: const Icon(
          Icons.info_outline,
          size: 28,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.00),
        ),
      );
}
