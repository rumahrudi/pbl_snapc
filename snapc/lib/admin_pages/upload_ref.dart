import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:snapc/auth/auth.dart';
import 'package:snapc/components/my_app_bar.dart';
import 'package:snapc/database/firestore.dart';
import 'package:snapc/theme/colors.dart';

class MyUpload extends StatefulWidget {
  const MyUpload({super.key});

  @override
  State<MyUpload> createState() => _MyUploadState();
}

class _MyUploadState extends State<MyUpload> {
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

  void allertAddToGallery() {
    // ! Allert succesfully add to cart
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: secondaryColor,
        title: const Center(
          child: Text(
            'Successfully Add to Gallery',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
        ),
        content: const Text(
          'Check yout gallery',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const MyAppBar(
        text: 'Add Gallery',
      ),
      body: Scaffold(
        body: Center(
          child: GestureDetector(
            onTap: () {
              firestoreService.addToGallery();
              allertAddToGallery();
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  'Add Gallery',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
