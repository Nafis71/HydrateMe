import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../Utils/constants.dart';

class ViewAllDrinkListNoDataLayout extends StatelessWidget {
  const ViewAllDrinkListNoDataLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.45,
            child: SvgPicture.asset(
              drinkListNoHistoryImage,
              fit: BoxFit.contain,
            ),
          ),
          const Wrap(
            children: [
              Text(
                noDataFoundText,
                style: TextStyle(fontSize: 15),
              ),
            ],
          )
        ],
      ),
    );
  }
}
