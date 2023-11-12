import 'package:flutter/material.dart';
import 'package:snapc/components/my_app_bar.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: const MyAppBar(text: 'About Us'),
    );
  }
}
