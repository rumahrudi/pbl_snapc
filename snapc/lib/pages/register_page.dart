import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:snapc/components/my_button.dart';
import 'package:snapc/components/my_textfield.dart';
import 'package:snapc/theme/colors.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({
    super.key,
    required this.onTap,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //* text editing controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void signUp() async {
    // * make sure password match
    if (passwordController.text != confirmPasswordController.text) {
      // * show error to user
      displayMessage('Passwords don`t match');
      return;
    }

    // * show loading circle
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // * create doc in Firestore called Users
      FirebaseFirestore.instance
          .collection('Users')
          .doc(userCredential.user!.email!)
          .set({
        'username': emailController.text.split('@')[0],
        'bio': 'Empty bio ...',
        'role': 'user',
      });

      // * pop loading circle
      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // * close loading circle
      Navigator.pop(context);
      // * show error to user
      displayMessage(e.code);
    }
  }

  void displayMessage(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: secondaryColor,
        title: Center(
          child: Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),

                    Image.asset(
                      'lib/images/logo.png',
                      width: 150,
                      height: 150,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    // welcome back

                    Text(
                      'Lets create an account for you',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(
                      height: 50,
                    ),
                    // username
                    MyTextField(
                      controller: emailController,
                      hintText: 'Username',
                      obsecureText: false,
                      readOnly: false,
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    //* passsword
                    MyTextField(
                      controller: passwordController,
                      hintText: 'Password',
                      obsecureText: true,
                      readOnly: false,
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    // * confirm password
                    MyTextField(
                      controller: confirmPasswordController,
                      hintText: 'Confirm Password',
                      obsecureText: true,
                      readOnly: false,
                    ),

                    const SizedBox(
                      height: 25,
                    ),
                    //* sign in button
                    MyButton(
                      isVisible: true,
                      text: 'Sign Up',
                      onTap: signUp,
                    ),

                    const SizedBox(
                      height: 25,
                    ),

                    //* not a memeber ? register now

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account ?',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        GestureDetector(
                          onTap: widget.onTap,
                          child: const Text(
                            'Login now',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
