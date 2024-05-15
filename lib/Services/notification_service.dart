import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:water_tracker/Models/notification_register_model.dart';
import 'package:water_tracker/Utils/constants.dart';
import 'package:water_tracker/Utils/hive_boxes.dart';

class NotificationService {
  static void initializeNotification() async {
    AwesomeNotifications().initialize(
        null,
        [
          NotificationChannel(
            channelGroupKey: notificationChannelGroupKey,
            channelKey: notificationChannelKey,
            channelName: notificationChannelName,
            channelDescription: notificationChannelDescription,
            defaultColor: Colors.white,
            ledColor: Colors.white,
            importance: NotificationImportance.Max,
            playSound: true,
          ),
        ],
        channelGroups: [
          NotificationChannelGroup(
              channelGroupKey: notificationChannelGroupKey,
              channelGroupName: notificationChannelGroupName)
        ],
        debug: true);

    await AwesomeNotifications().setListeners(
      onNotificationDisplayedMethod:
          (ReceivedNotification receivedNotification) async {
        onNotificationDisplayed(receivedNotification);
          },
      onActionReceivedMethod: (ReceivedAction receivedAction) async {
        debugPrint("testing");
      },
    );
  }

  static Future<void> onNotificationDisplayed(
      ReceivedNotification receivedNotification) async {
    Box hiveBox = HiveBoxes.getNotificationData();
    int length = hiveBox.length;
    for (int index = 0; index < length; index++) {
      if (hiveBox.get(index).id == receivedNotification.id &&
          hiveBox.get(index).repeatType == "Once") {
        NotificationRegisterModel notificationRegisterModel =
            hiveBox.get(index);
        notificationRegisterModel.isReminderEnabled = false;
        notificationRegisterModel.save();
      }
    }
  }

  static Future<void> createScheduledNotification({
    required int id,
    required String channelKey,
    required String title,
    required String body,
    required int hour,
    required int minute,
    required int second,
    required bool repeat,
  }) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: channelKey,
        title: title,
        body: body,
      ),
      schedule: NotificationCalendar(
        hour: hour,
        minute: minute,
        second: second,
        repeats: repeat,
      ),
    );
  }

  static Future<bool> checkNotificationPermission() async {
    bool hasPermission =
        await AwesomeNotifications().isNotificationAllowed().then(
      (isAllowed) async {
        if (!isAllowed) {
          return await AwesomeNotifications()
              .requestPermissionToSendNotifications();
        }
        return true;
      },
    );
    return (hasPermission) ? true : false;
  }
}
