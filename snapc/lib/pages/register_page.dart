import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:snapc/components/my_button.dart';
import 'package:snapc/components/my_textfield.dart';
import 'package:snapc/theme/colors.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  RegisterPage({
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
    // * show loading circe
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    // * make sure password match
    if (passwordController.text != confirmPasswordController.text) {
      // * pop loading circle
      Navigator.pop(context);
      // * show eror to user
      displayMessage('Password don`t match');
      return;
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // * pop loading circle
      Navigator.pop(context);
      // * show eror to user
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
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    //* passsword
                    MyTextField(
                      controller: passwordController,
                      hintText: 'Password',
                      obsecureText: true,
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    // * confirm password
                    MyTextField(
                      controller: confirmPasswordController,
                      hintText: 'Confirm Password',
                      obsecureText: true,
                    ),

                    const SizedBox(
                      height: 25,
                    ),
                    //* sign in button
                    MyButton(
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
                          child: Text(
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
