import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Text(
          'Register Now',
          style: TextStyle(fontSize: 28),
        ),
      ),
    );
  }
}
