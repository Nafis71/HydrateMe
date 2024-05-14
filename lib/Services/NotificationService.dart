import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationService {
  static void initializeNotification() {
    AwesomeNotifications().initialize(
        null,
        [
          NotificationChannel(
            channelGroupKey: "TestingChannelGroup",
            channelKey: "TestingChannel",
            channelName: "Water Reminder Channel",
            channelDescription:
                "Notification channel for reminding water intake",
            defaultColor: Colors.white,
            ledColor: Colors.white,
            importance: NotificationImportance.Max,
            playSound: true,
          ),
        ],
        channelGroups: [
          NotificationChannelGroup(
              channelGroupKey: 'TestingChannelGroup',
              channelGroupName: 'Testing group')
        ],
        debug: true);
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


  static Future<bool> checkNotificationPermission() async{
    bool hasPermission = await AwesomeNotifications().isNotificationAllowed().then(
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
