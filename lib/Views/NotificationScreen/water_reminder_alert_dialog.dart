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
          content: SizedBox(
            height: (orientation == Orientation.portrait)
                ? MediaQuery.of(context).size.height * 0.2
                : MediaQuery.of(context).size.height * 0.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Wrap(
                  spacing: 3,
                  children: [
                    Text(
                      selectedTime!.format(context),
                      style: const TextStyle(
                          fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: () async {
                    chooseTime();
                  },
                  icon: const Icon(Icons.watch_later_outlined),
                  label: const Text("Choose Time"),
                ),
                const SizedBox(height: 10),
                CheckboxListTile(
                  title: const Text("Repeat"),
                  value: isRepeatable,
                  onChanged: (value) {
                    changeNotificationMode(value);
                  },
                  activeColor: appPrimaryColor,
                ),
              ],
            ),
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
