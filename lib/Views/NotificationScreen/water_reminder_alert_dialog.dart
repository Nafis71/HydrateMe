import 'package:flutter/material.dart';

import '../../Utils/colors.dart';
import '../../Utils/constants.dart';

class WaterReminderAlertDialog extends StatelessWidget {
  final TimeOfDay? selectedTime;
  final Function chooseTime, setReminder;
  final Function(dynamic) changeNotificationMode;
  final bool isRepeatable;
  const WaterReminderAlertDialog({super.key, required this.selectedTime, required this.chooseTime, required this.changeNotificationMode, required this.isRepeatable, required this.setReminder});

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (BuildContext context, Orientation orientation) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Center(
            child: Text(
              alertDialogHeader,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Wrap(
                spacing: 2,
                children: [
                  Text(
                    selectedTime!.format(context),
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              ElevatedButton.icon(
                onPressed: () async {
                  chooseTime();
                },
                icon: const Icon(Icons.watch_later_outlined),
                label: const Text("Choose Time"),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.09,
                child: CheckboxListTile(
                  title: const Text("Repeat"),
                  value: isRepeatable,
                  onChanged: (value) {
                    changeNotificationMode(value);
                  },
                  activeColor: appPrimaryColor,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setReminder();
              },
              child: const Text(
                "Set Reminder",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            )
          ],
        );
      },
    );
  }
}
