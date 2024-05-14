import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive/hive.dart';
import 'package:water_tracker/Models/notification_register_model.dart';
import 'package:water_tracker/Services/NotificationService.dart';
import 'package:water_tracker/Utils/hive_boxes.dart';
import 'package:water_tracker/Views/NotificationScreen/water_reminder_alert_dialog.dart';
import 'package:water_tracker/Views/NotificationScreen/water_reminder_no_notification_layout.dart';
import 'package:water_tracker/Views/NotificationScreen/water_reminder_notification_list_layout.dart';

import '../../Utils/colors.dart';
import '../../Utils/constants.dart';

class WaterReminderScreenView extends StatefulWidget {
  const WaterReminderScreenView({super.key});

  @override
  State<WaterReminderScreenView> createState() =>
      _WaterReminderScreenViewState();
}

class _WaterReminderScreenViewState extends State<WaterReminderScreenView> {
  late TimeOfDay? selectedTime;
  bool isRepeatable = true;
  late Orientation screenOrientation;
  late List<NotificationRegisterModel> models;
  Box hiveBox = HiveBoxes.getNotificationData();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    models = getNotificationModels();
    int itemCount = models.length;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reminder"),
      ),
      body: SafeArea(
        child: (itemCount == 0)
            ? const NoNotificationLayout()
            : ListView.separated(
                itemCount: itemCount,
                itemBuilder: (context, index) {
                  return NotificationListLayout(
                      removeFromList: () {
                        _removeNotificationRegistry(index, models[index]);
                      },
                      models: models,
                      notificationSettingToggle: (value) {
                        models[index].isReminderEnabled = value;
                        setState(() {});
                      },
                      index: index);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: appPrimaryColor,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.00)),
        onPressed: () async {
          bool hasPermission =
              await NotificationService.checkNotificationPermission();
          if (hasPermission) {
            showAlertDialog();
          }
        },
        child: const Icon(
          Icons.add,
          size: 30,
          color: Colors.white,
        ),
      ),
    );
  }

  void _removeNotificationRegistry(
      int index, NotificationRegisterModel notificationRegisterModel) async {
    AwesomeNotifications().cancelSchedule(models[index].id);
    models.removeAt(index);
    await notificationRegisterModel.delete();
    if (hiveBox.isEmpty) {
      hiveBox.clear();
    }
    setState(() {});
  }

  List<NotificationRegisterModel> getNotificationModels() {
    List<NotificationRegisterModel> models = [];
    Box hiveBox = HiveBoxes.getNotificationData();
    int length = hiveBox.length;
    for (int index = 0; index < length; index++) {
      models.add(hiveBox.get(index));
    }
    return models;
  }

  void showAlertDialog() {
    selectedTime = TimeOfDay.now();
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (BuildContext context, setDialogState) {
          return WaterReminderAlertDialog(
            selectedTime: selectedTime,
            chooseTime: () async {
              selectedTime = await launchTimePicker(selectedTime!);
              setDialogState(() {});
            },
            changeNotificationMode: (value) {
              isRepeatable = value!;
              setDialogState(() {});
            },
            isRepeatable: isRepeatable,
            setReminder: setReminder,
          );
        },
      ),
    );
  }

  Future<TimeOfDay?> launchTimePicker(TimeOfDay timeOfDay) async {
    return selectedTime = await showTimePicker(
      confirmText: "Select",
      context: context,
      initialTime: timeOfDay,
    );
  }

  void setReminder() {
    Random random = Random();
    int id = random.nextInt(999);
    NotificationService.createScheduledNotification(
        id: id,
        channelKey: "TestingChannel",
        title: "You need to drink water",
        body: "You have added an alarm to remind you to drink water",
        hour: selectedTime!.hour.toInt(),
        minute: selectedTime!.minute.toInt(),
        second: 0,
        repeat: false);
    saveToDatabase(id);
  }

  void saveToDatabase(int id) {
    NotificationRegisterModel notificationModel = NotificationRegisterModel(
      id: id,
      time: selectedTime!.format(context).toString(),
      repeatType: (isRepeatable) ? "Repeat" : "Once",
      isReminderEnabled: true,
    );
    hiveBox.add(notificationModel);
    print(hiveBox.values);
    setState(() {});
  }
}
