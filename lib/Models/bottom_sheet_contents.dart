import 'package:flutter/material.dart';

class BottomSheetContents {
  final int id;
  final String header;
  final Color backgroundColor, borderColor;
  final IconData icon;
  bool isSelected;

  BottomSheetContents({
    required this.id,
    required this.header,
    required this.backgroundColor,
    required this.borderColor,
    required this.icon,
    required this.isSelected,
  });
}

List<BottomSheetContents> containerContents = [
  BottomSheetContents(
    id: 1,
    header: "Water",
    backgroundColor: const Color(0xFFE3F2FD),
    borderColor: Colors.blue,
    icon: Icons.water_drop_outlined,
    isSelected: false,
  ),
  BottomSheetContents(
    id: 2,
    header: "Tea",
    backgroundColor: const Color(0xFFF0FCE5),
    borderColor: Colors.lightGreen,
    icon: Icons.energy_savings_leaf,
    isSelected: false,
  ),
  BottomSheetContents(
    id: 3,
    header: "Coffee",
    backgroundColor: const Color(0xFFF8F5F2),
    borderColor: const Color(0xFFC19F80),
    icon: Icons.coffee,
    isSelected: false,
  ),
  BottomSheetContents(
    id: 4,
    header: "Juice",
    backgroundColor: const Color(0xFFFEF4F0),
    borderColor: const Color(0xFFF99570),
    icon: Icons.apple,
    isSelected: false,
  ),
];
