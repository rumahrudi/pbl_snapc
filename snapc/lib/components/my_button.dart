import 'package:flutter/material.dart';
import 'package:snapc/theme/colors.dart';

class MyButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  final bool isVisible;
  const MyButton(
      {super.key,
      required this.text,
      required this.onTap,
      required this.isVisible});

  @override
  Widget build(BuildContext context) {
    return isVisible
        ? GestureDetector(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.all(25),
              // margin: const EdgeInsets.symmetric(horizontal: 25.0),
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
