import 'package:flutter/material.dart';
import 'package:snapc/theme/colors.dart';

class MyTextBox extends StatelessWidget {
  final String sectionName;
  final String text;
  final Function()? onPressed;
  const MyTextBox({
    super.key,
    required this.sectionName,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.only(
        left: 15,
        bottom: 15,
      ),
      margin: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // * section name
              Text(
                sectionName,
                style: TextStyle(color: Colors.grey[500]),
              ),
              // * icon button
              IconButton(
                onPressed: onPressed,
                icon: Icon(
                  Icons.settings,
                  color: secondaryColor,
                ),
              )
            ],
          ),
          // * text
          Text(text),
        ],
      ),
    );
  }
}
