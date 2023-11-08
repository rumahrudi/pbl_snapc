import 'package:flutter/material.dart';

class DateField extends StatelessWidget {
  final Function()? onTap;
  final String hintText;
  const DateField({
    super.key,
    required this.onTap,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: false,
      readOnly: true,
      onTap: onTap,
      decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
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
    );
  }
}
