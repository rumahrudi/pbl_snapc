import 'package:flutter/material.dart';

class MyNote extends StatelessWidget {
  final String note;
  final bool isVisible;
  const MyNote({super.key, required this.isVisible, required this.note});

  @override
  Widget build(BuildContext context) {
    return isVisible
        ? Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.yellow[100],
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Note',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      note,
                      textAlign: TextAlign.justify,
                    )
                  ],
                ),
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
