import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:snapc/components/my_app_bar.dart';
// import 'package:snapc/theme/colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // * user
  final currentUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: MyAppBar(text: 'My Profile'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // * Hello user
          Center(child: Text('Hay ' + currentUser.email!)),
        ],
      ),
    );
  }
}
