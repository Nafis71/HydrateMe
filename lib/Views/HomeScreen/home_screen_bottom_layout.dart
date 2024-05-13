import 'package:flutter/material.dart';
import 'package:water_tracker/Models/person_data.dart';
import '../../Utils/colors.dart';

class HomeScreenBottomLayout extends StatelessWidget {
  final double screenWidth, screenHeight;
  final Orientation orientation;
  final PersonData personData;
  final int drankWater;

  const HomeScreenBottomLayout({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.orientation,
    required this.drankWater, required this.personData,
  });

  @override
  Widget build(BuildContext context) {
    double containerScreenWidth = (orientation == Orientation.portrait)
        ? screenWidth * 0.35
        : screenWidth * 0.21;
    double containerScreenHeight = (orientation == Orientation.portrait)
        ? screenHeight * 0.08
        : screenHeight * 0.24;
    return Expanded(
      flex: (orientation == Orientation.portrait) ? 0 : 2,
      child: Container(
        width: screenWidth,
        height: containerScreenHeight,
        color: Colors.white,
        alignment: Alignment.center,
        margin: const EdgeInsets.all(0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: containerScreenWidth,
              height: containerScreenHeight,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.white, width: 0),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  bottomLeft: Radius.circular(40),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.10),
                    blurRadius: 30,
                    blurStyle: BlurStyle.normal,
                    spreadRadius: 6,
                    offset: const Offset(0, 20),
                  )
                ],
              ),
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          "Drank",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          "${drankWater.toString()}ml",
                          style: const TextStyle(
                            color: appPrimaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              width: containerScreenWidth,
              height: containerScreenHeight,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.white, width: 0),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.10),
                    blurRadius: 30,
                    blurStyle: BlurStyle.normal,
                    spreadRadius: 6,
                    offset: const Offset(0, 20),
                  )
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          "Goal",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          "${personData.calculateWaterIntakeGoal().toString()}ml",
                          style: const TextStyle(
                            color: appPrimaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
