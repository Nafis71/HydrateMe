import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:water_tracker/Utils/constants.dart';
import 'package:water_tracker/Utils/hive_boxes.dart';

import '../Models/notification_register_model.dart';
import '../Services/notification_service.dart';

class WaterReminderController {
  BuildContext context;

  WaterReminderController(this.context);

  Future<TimeOfDay> launchTimePicker(TimeOfDay timeOfDay) async {
    return await showTimePicker(
      confirmText: selectText,
      context: context,
      initialTime: timeOfDay,
    ) ?? TimeOfDay.now();
  }

  List<NotificationRegisterModel> getNotificationModels() {
    List<NotificationRegisterModel> models = [];
    Box hiveBox = HiveBoxes.getNotificationData();
    int length = hiveBox.length;
    for (int index = 0; index < length; index++) {
      models.add(hiveBox.getAt(index));
    }
    return models;
  }

  void setReminder({required Box hiveBox,
    required TimeOfDay selectedTime,
    required bool isRepeatable}) {
    Random random = Random();
    int id = random.nextInt(999);
    NotificationService.createScheduledNotification(
        id: id,
        channelKey: notificationChannelKey,
        title: notificationTitle,
        body: notificationBody,
        hour: selectedTime.hour.toInt(),
        minute: selectedTime.minute.toInt(),
        second: 0,
        repeat: isRepeatable);
    saveToDatabase(
        id: id,
        hiveBox: hiveBox,
        selectedTime: selectedTime,
        isRepeatable: isRepeatable);
  }

  void saveToDatabase({required int id,
    required Box hiveBox,
    required TimeOfDay selectedTime,
    required bool isRepeatable}) {
    NotificationRegisterModel notificationModel = NotificationRegisterModel(
      id: id,
      time: selectedTime.format(context).toString(),
      repeatType: (isRepeatable)
          ? repeatedNotificationText
          : nonRepeatedNotificationText,
      isReminderEnabled: true,
    );
    hiveBox.add(notificationModel);
  }


  Future<void> toggleNotification(
      {required NotificationRegisterModel notificationRegisterModel, required bool isReminderEnabled}) async {
    if (isReminderEnabled) {
      AwesomeNotifications().cancelSchedule(notificationRegisterModel.id);
      DateTime dateTime = DateFormat("h:mm a").parse(notificationRegisterModel.time);
      TimeOfDay notificationTime = TimeOfDay.fromDateTime(dateTime);
      NotificationService.createScheduledNotification(id: notificationRegisterModel.id,
          channelKey: notificationChannelKey,
          title: notificationTitle,
          body: notificationBody,
          hour: notificationTime.hour,
          minute: notificationTime.minute,
          second: 0,
          repeat: (notificationRegisterModel.repeatType == repeatedNotificationText) ? true : false);
    } else {
      AwesomeNotifications().cancelSchedule(notificationRegisterModel.id);
    }
  }

  Future<void> removeNotificationRegistry({
    required int index,
    required NotificationRegisterModel notificationRegisterModel,
    required List<NotificationRegisterModel> models,
    required Box hiveBox,
  }) async {
    AwesomeNotifications().cancelSchedule(models[index].id);
    await hiveBox.deleteAt(index);
    if (hiveBox.isEmpty) {
      await hiveBox.clear();
    }
  }

}
