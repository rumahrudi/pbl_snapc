import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import paket cloud_firestore
import 'package:snapc/admin_pages/admin_dashboard.dart';

import 'package:snapc/auth/login_or_register.dart';
import 'package:snapc/pages/intro_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // * take email from current user
            final currentUser = FirebaseAuth.instance.currentUser!;

            //* get user data from firestore
            return FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('Users')
                  .doc(currentUser.email)
                  .get(),
              builder: (context, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                  //* show loading
                }

                //* take role from Firestore
                final userRole = userSnapshot.data?['role'];

                // * give acces depends on role
                if (userRole == 'admin') {
                  return const Dasboard();
                  //* navigate to dasboard admin
                } else if (userRole == 'user') {
                  return const IntroPage();
                } else {
                  return const LoginOrRegister();
                  //* navigate to login or register
                }
              },
            );
          } else {
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}
