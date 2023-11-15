import 'package:flutter/material.dart';

class MyNote extends StatelessWidget {
  final bool isVisible;
  const MyNote({super.key, required this.isVisible});

  @override
  Widget build(BuildContext context) {
    return isVisible
        ? Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.yellow[100],
                  borderRadius: BorderRadius.circular(12)),
              child: const Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Note',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                        'Please make Payment and upload proof of your payment before the expiration date !')
                  ],
                ),
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
