import 'package:flutter/material.dart';

class DateField extends StatelessWidget {
  final Function()? onTap;
  final String hintText;
  final bool isVisible;
  const DateField({
    super.key,
    required this.onTap,
    required this.hintText,
    required this.isVisible,
  });

  @override
  Widget build(BuildContext context) {
    return isVisible
        ? TextField(
            obscureText: false,
            readOnly: true,
            onTap: onTap,
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade400,
                  ),
                ),
                fillColor: Colors.grey.shade200,
                filled: true,
                hintText: hintText,
                hintStyle: TextStyle(color: Colors.grey[500])),
          )
        : const SizedBox.shrink();
  }
}
