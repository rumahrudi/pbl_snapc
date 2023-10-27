import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
          // * user is loged in
          if (snapshot.hasData) {
            return const IntroPage();
          }
          // * user is not loged in
          else {
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}
