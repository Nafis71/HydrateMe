import 'package:flutter/material.dart';

class HomeScreenRecentlyDrankInfo extends StatelessWidget {
  final double screenWidth, screenHeight;
  final Orientation orientation;

  const HomeScreenRecentlyDrankInfo({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.orientation,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenWidth * 0.9,
      height: (orientation == Orientation.portrait)
          ? screenHeight * 0.15
          : screenHeight * 0.35,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Row(
            children: [
              Text(
                "Recently Drank",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            title: const Text(
              "Coffee",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            tileColor: Colors.blue[50],
            leading: const Icon(
              Icons.coffee,
              size: 28,
            ),
            subtitle: const Text("200ml"),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.00),
            ),
          )
        ],
      ),
    );
  }
}
