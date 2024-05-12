import 'package:hive/hive.dart';

part 'water_intake_model.g.dart';

@HiveType(typeId: 0)
class WaterIntakeModel extends HiveObject {
  @HiveField(0)
  String drinkName;

  @HiveField(1)
  String drinkSize;

  @HiveField(2)
  DateTime dateTime;

  WaterIntakeModel({
    required this.drinkName,
    required this.drinkSize,
    required this.dateTime,
  });
}
