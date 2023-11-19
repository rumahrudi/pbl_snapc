import 'package:flutter/material.dart';

class MyGap extends StatelessWidget {
  final double? height;
  final bool isVisible;
  const MyGap({
    super.key,
    required this.height,
    required this.isVisible,
  });

  @override
  Widget build(BuildContext context) {
    return isVisible
        ? SizedBox(
            height: height,
          )
        : const SizedBox.shrink();
  }
}
