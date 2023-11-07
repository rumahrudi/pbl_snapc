import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:snapc/components/my_app_bar.dart';
import 'package:snapc/database/firestore.dart';

class Dasboard extends StatefulWidget {
  const Dasboard({super.key});

  @override
  State<Dasboard> createState() => _DasboardState();
}

class _DasboardState extends State<Dasboard> {
  // * user
  final currentUser = FirebaseAuth.instance.currentUser!;

  // * firestore
  final FirestoreService firestoreService = FirestoreService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: const MyAppBar(
        text: 'Dashboard',
      ),
      body: const Scaffold(
        body: Text(
          'My Dasboard',
        ),
      ),
    );
  }
}
