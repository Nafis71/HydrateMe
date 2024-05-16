import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../Models/water_intake_model.dart';
import '../../Utils/colors.dart';
import '../../Utils/constants.dart';
import '../../Utils/water_list_icons.dart';

class ViewAllDrinkListLayout extends StatelessWidget {
  String displayedDatetimeHeader;
  List<WaterIntakeModel> waterIntakeModel;
  ViewAllDrinkListLayout({super.key, required this.displayedDatetimeHeader, required this.waterIntakeModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(DateFormat.MMMMEEEEd().format(waterIntakeModel[0].dateTime),style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w700
              ),),
            ],
          ),
          const SizedBox(height: 5,),
          Expanded(child: Material(
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
                  subtitle: Text("${waterIntakeModel[index].drinkSize}$sizeMetric"),

                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat.MMMMEEEEd().format(waterIntakeModel[index].dateTime),
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
                return separatorWidget(waterIntakeModel, index);
              },
            ),
          ),)
        ],
      ),
    );
  }

  Widget separatorWidget(List<WaterIntakeModel> waterIntakeModel, int index){
    String modelDateTime = DateFormat.MMMMEEEEd().format(waterIntakeModel[index].dateTime);
    if(modelDateTime == displayedDatetimeHeader){
      return const SizedBox(
        height: 10,
      );
    }
    return Column(
      children: [
        const SizedBox(height: 5,),
        Row(
          children: [
            Text(DateFormat.MMMMEEEEd().format(waterIntakeModel[index].dateTime),style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w700
            ),),
          ],
        ),
        const SizedBox(height: 5,),
      ],
    );
  }
}
