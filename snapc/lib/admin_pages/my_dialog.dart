import 'package:flutter/material.dart';
import 'package:snapc/theme/colors.dart';

class MyDialog extends StatefulWidget {
  final String field;
  final String initialValue;
  final List<String> options;

  MyDialog(
      {required this.field, required this.initialValue, required this.options});

  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  late String selectedValue;
  late bool isCancelled;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue;
    isCancelled = false;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: secondaryColor,
      title: Text(
        'Edit ${widget.field}',
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: widget.options.map((option) {
          return RadioListTile(
            title: Text(option),
            value: option,
            groupValue: selectedValue,
            onChanged: (value) {
              setState(() {
                selectedValue = value as String;
              });
            },
          );
        }).toList(),
      ),
      actions: [
        TextButton(
          onPressed: () {
            setState(() {
              isCancelled = true;
            });
            Navigator.pop(context, this);
          },
          child: const Text(
            'Cancel',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(this);
          },
          child: const Text(
            'Save',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
