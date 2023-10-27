import 'package:flutter/material.dart';
import 'package:snapc/components/my_button.dart';
import 'package:snapc/components/my_textfield.dart';

class RegisterPage extends StatelessWidget {
  final Function()? onTap;
  RegisterPage({
    super.key,
    required this.onTap,
  });

  // text editing controller
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

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
                      controller: usernameController,
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
                      onTap: () {},
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
                          onTap: onTap,
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
