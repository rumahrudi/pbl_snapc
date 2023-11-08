import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:snapc/components/my_button.dart';
import 'package:snapc/components/my_textfield.dart';
import 'package:snapc/theme/colors.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({
    super.key,
    required this.onTap,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //* text editing controller
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  //* sign in user
  void signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // * pop loading circle
      // if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // * pop loading circle
      // Navigator.pop(context);
      // * display eror message
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
      backgroundColor: Colors.grey[300],
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
                      'Welcome back you`ve been missed!',
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
                    // passsword
                    MyTextField(
                      controller: passwordController,
                      hintText: 'Password',
                      obsecureText: true,
                      readOnly: false,
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    //* forgot pasword
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Forgot Password ?',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 25,
                    ),
                    //* sign in button
                    MyButton(
                      text: 'Sign In',
                      onTap: signIn,
                    ),

                    const SizedBox(
                      height: 25,
                    ),

                    //* not a memeber ? register now

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Not a member ?',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        GestureDetector(
                          onTap: widget.onTap,
                          child: Text(
                            'Register now',
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
