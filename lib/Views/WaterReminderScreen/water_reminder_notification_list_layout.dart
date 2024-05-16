import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../Models/notification_register_model.dart';
import '../../Utils/colors.dart';

class NotificationListLayout extends StatelessWidget {
  final Function removeFromList, updateNotificationTime;
  final Function(dynamic) notificationSettingToggle;
  final List<NotificationRegisterModel> models;
  final int index;

  const NotificationListLayout(
      {super.key,
      required this.removeFromList,
      required this.models,
      required this.notificationSettingToggle,
      required this.index,
      required this.updateNotificationTime});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Slidable(
        key: Key(index.toString()),
        startActionPane: ActionPane(
          motion: const DrawerMotion(),
          openThreshold: 0.2,
          dismissible: DismissiblePane(
            onDismissed: () => removeFromList(),
          ),
          children: [
            SlidableAction(
              onPressed: (context) => removeFromList(),
              icon: Icons.delete,
              label: "Delete",
              spacing: 10,
              backgroundColor: Colors.redAccent,
            ),
            SlidableAction(
              onPressed: (context) => updateNotificationTime(),
              icon: Icons.edit,
              label: "Edit",
              spacing: 10,
              backgroundColor: appPrimaryColor,
            ),
          ],
        ),
        child: ListTile(
          tileColor: lightBlue,
          leading: const Icon(
            Icons.watch_later,
            color: appPrimaryColor,
            size: 30,
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.00)),
          title: Text(
            models[index].time,
            style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
          ),
          trailing: Switch(
            value: models[index].isReminderEnabled,
            onChanged: (bool value) {
              notificationSettingToggle(value);
            },
            activeColor: appPrimaryColor,
          ),
          subtitle: Text(models[index].repeatType),
          contentPadding: const EdgeInsets.all(10.00),
        ),
      ),
    );
  }
}
