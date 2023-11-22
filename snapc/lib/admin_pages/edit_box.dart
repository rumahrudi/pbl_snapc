import 'package:flutter/material.dart';
import 'package:snapc/theme/colors.dart';

class EditBox extends StatelessWidget {
  final String sectionName;
  final String text;
  final Function()? onPressed;
  const EditBox({
    super.key,
    required this.sectionName,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: thirdColor,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.only(
        left: 15,
        bottom: 15,
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
