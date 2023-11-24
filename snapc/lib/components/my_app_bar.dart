import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  const MyAppBar({
    super.key,
    required this.text,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: const [
        IconButton(
          onPressed: null,
          icon: Icon(
            Icons.shopping_bag_rounded,
            color: Colors.transparent,
          ),
        )
      ],
      // iconTheme: const IconThemeData(color: Colors.black),
      title: Center(
        child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
