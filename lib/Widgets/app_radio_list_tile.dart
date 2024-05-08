import 'package:flutter/material.dart';

class AppRadioListTile extends StatelessWidget {
  final String gender, genderRadioOption;
  final Function(dynamic) onChanged;

  const AppRadioListTile({
    super.key,
    required this.gender,
    required this.genderRadioOption,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return RadioListTile(
      title: Text(genderRadioOption),
      tileColor: Colors.blue[50],
      contentPadding: const EdgeInsets.all(5.00),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),topRight: Radius.circular(30.00)),
      ),
      value: genderRadioOption,
      activeColor: Colors.blue,
      groupValue: gender,
      onChanged: onChanged,
    );
  }
}
