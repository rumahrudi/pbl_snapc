import 'package:flutter/material.dart';

class AdminCard extends StatelessWidget {
  final Color? color;
  final String linkImage;
  final String title;
  final Function()? onTap;
  const AdminCard({
    super.key,
    required this.color,
    required this.linkImage,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8, bottom: 8),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                linkImage,
                width: 150,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25, //* 14 if one row 2 card
                    color: Colors.grey[600]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
