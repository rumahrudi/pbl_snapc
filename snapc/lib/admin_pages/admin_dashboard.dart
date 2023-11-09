import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:snapc/auth/auth.dart';
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

  void signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const AuthPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: const MyAppBar(
        text: 'Dashboard',
      ),
      body: Scaffold(
        body: Center(
          child: GestureDetector(
            onTap: () {
              signOut(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Container(
                decoration: const BoxDecoration(color: Colors.blue),
                child: const Text(
                  'L O G O U T',
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
