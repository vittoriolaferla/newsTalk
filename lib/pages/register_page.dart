import 'package:dima/utils/alert_login_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dima/utils/my_button.dart';
import 'package:dima/utils/my_textfield.dart';
import 'package:dima/utils/square_tile.dart';
import 'package:dima/managers/services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onLoginTap;
  const RegisterPage({super.key, required this.onLoginTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // sign user up method
  void signUserUp() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.black,
          ),
        );
      },
    );

    // try to create firebase account
    try {
      // check if passwords match
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        // pop loading circle
        Navigator.pop(context);
      } else {
        // pop loading circle
        Navigator.pop(context);
        // show alert
        showDialog(
          context: context,
          builder: (context) =>
              AlertLoginDialog(text: 'Passwords do not match!'),
        );
      }
    } on FirebaseAuthException catch (e) {
      // pop loading circle
      Navigator.pop(context);
      if (true) {
        //TODO specific exceptions
        // Show alert
        showDialog(
          context: context,
          builder: (context) =>
              AlertLoginDialog(text: 'Wrong email or password'),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 25),

                // logo
                const Icon(
                  Icons.account_box_rounded,
                  size: 100,
                ),

                const SizedBox(height: 25),

                // lets create an account!
                Text(
                  'Let\'s create and account!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 25),

                // email textfield
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                // password textfield
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                const SizedBox(height: 10),

                // confirm password textfield
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),

                const SizedBox(height: 10),

                // forgot password?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // sign in button
                MyButton(onTap: signUserUp, text: 'Sign Up'),

                const SizedBox(height: 20),

                // or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),

                //const SizedBox(height: 40),

                // google + apple sign in buttons
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // google button
                      SquareTile(
                          imagePath: 'assets/images/google.png',
                          onTap: () => AuthService().signInWithGoogle()),

                      SizedBox(width: 25),

                      // apple button
                      SquareTile(
                          imagePath: 'assets/images/apple.png',
                          onTap: () {} // TODO ADD APPLE LOGIN
                          )
                    ],
                  ),
                ),

                //const SizedBox(height: 30),

                // not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onLoginTap,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
