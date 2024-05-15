import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:water_tracker/Controllers/water_reminder_controller.dart';
import 'package:water_tracker/Models/notification_register_model.dart';
import 'package:water_tracker/Services/NotificationService.dart';
import 'package:water_tracker/Utils/hive_boxes.dart';
import 'package:water_tracker/Views/NotificationScreen/water_reminder_alert_dialog.dart';
import 'package:water_tracker/Views/NotificationScreen/water_reminder_no_notification_layout.dart';
import 'package:water_tracker/Views/NotificationScreen/water_reminder_notification_list_layout.dart';
import '../../Utils/colors.dart';

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
  late final WaterReminderController waterReminderController;
  Box hiveBox = HiveBoxes.getNotificationData();

  @override
  void initState() {
    waterReminderController = WaterReminderController(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    models = waterReminderController.getNotificationModels();
    int itemCount = models.length;
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
                        waterReminderController.removeNotificationRegistry(
                          index: index,
                          notificationRegisterModel: models[index],
                          models: models,
                          hiveBox: hiveBox,
                        );
                        setState(() {});
                      },
                      models: models,
                      notificationSettingToggle: (value) {
                        models[index].isReminderEnabled = value;
                        setState(() {});
                      },
                      index: index);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 10);
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

  void showAlertDialog() {
    selectedTime = TimeOfDay.now();
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (BuildContext context, setDialogState) {
          return WaterReminderAlertDialog(
            selectedTime: selectedTime,
            chooseTime: () async {
              selectedTime = await waterReminderController.launchTimePicker(
                selectedTime!,
              );
              setDialogState(() {});
            },
            changeNotificationMode: (value) {
              isRepeatable = value!;
              setDialogState(() {});
            },
            isRepeatable: isRepeatable,
            setReminder: () {
              waterReminderController.setReminder(
                  hiveBox: hiveBox,
                  selectedTime: selectedTime!,
                  isRepeatable: isRepeatable);
              setState(() {});
            },
          );
        },
      ),
    );
  }
}
