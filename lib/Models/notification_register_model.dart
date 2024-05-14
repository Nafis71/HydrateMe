import 'package:hive/hive.dart';
part 'notification_register_model.g.dart';

@HiveType(typeId: 1)
class NotificationRegisterModel extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String time;

  @HiveField(2)
  String repeatType;
  @HiveField(3)
  bool isReminderEnabled;

  NotificationRegisterModel({required this.id, required this.time, required this.repeatType, required this.isReminderEnabled});
}
