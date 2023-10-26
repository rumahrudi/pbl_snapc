import 'package:flutter/material.dart';
import 'package:snapc/theme/colors.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  const MyAppBar({super.key, required this.text});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: secondaryColor,
      elevation: 0,
      actions: [
        IconButton(
          onPressed: null,
          icon: Icon(
            Icons.shopping_bag_rounded,
            color: secondaryColor,
          ),
        )
      ],
      iconTheme: IconThemeData(color: Colors.white),
      title: Center(
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
