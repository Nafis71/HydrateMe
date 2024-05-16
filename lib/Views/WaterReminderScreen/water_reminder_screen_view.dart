import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:water_tracker/Controllers/water_reminder_controller.dart';
import 'package:water_tracker/Models/notification_register_model.dart';
import 'package:water_tracker/Services/notification_service.dart';
import 'package:water_tracker/Utils/hive_boxes.dart';
import 'package:water_tracker/Views/WaterReminderScreen/water_reminder_alert_dialog.dart';
import 'package:water_tracker/Views/WaterReminderScreen/water_reminder_no_notification_layout.dart';
import 'package:water_tracker/Views/WaterReminderScreen/water_reminder_notification_list_layout.dart';
import '../../Utils/colors.dart';
import '../../Utils/constants.dart';
import '../Components/app_banner.dart';


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
  late Box hiveBox = HiveBoxes.getNotificationData();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text("Reminder"),
      ),
      body: SafeArea(
        child: (itemCount == 0)
            ? const NoNotificationLayout()
            : Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.3,
                  child: SvgPicture.asset(
                    "assets/images/notificationBackground.svg",
                    fit: BoxFit.contain,)),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Wrap(
                    alignment: WrapAlignment.start,
                    children: [
                      Text("Reminders", style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),)
                    ],
                  ),
                ],
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: itemCount,
                  itemBuilder: (context, index) {
                    return NotificationListLayout(
                        removeFromList: () async {
                          await waterReminderController
                              .removeNotificationRegistry(
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
                          waterReminderController.toggleNotification(
                              notificationRegisterModel: models[index],
                              isReminderEnabled: value);
                          setState(() {});
                        },
                        index: index);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 10);
                  },
                ),
              ),
            ],
          ),
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
      builder: (context) =>
          StatefulBuilder(
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
                  ScaffoldMessenger.of(context).showMaterialBanner((appBanner(
                      content: appBannerContent,
                      color: appPrimaryColor,
                      context: _scaffoldKey.currentContext!)));
                  setState(() {});
                },
              );
            },
          ),
    );
  }
}
