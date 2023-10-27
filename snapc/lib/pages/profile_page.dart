import 'package:flutter/material.dart';
import 'package:snapc/components/my_app_bar.dart';
// import 'package:snapc/theme/colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: MyAppBar(text: 'My Profile'),
    );
  }
}
