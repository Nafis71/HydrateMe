import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:hive/hive.dart';
import 'package:water_tracker/Models/notification_register_model.dart';

import '../Models/water_intake_model.dart';

class HiveBoxes{
  static Box<WaterIntakeModel> getWaterIntakeData() => Hive.box("WaterIntake");
  static Box<NotificationRegisterModel> getNotificationData() => Hive.box("NotificationRecord");
}