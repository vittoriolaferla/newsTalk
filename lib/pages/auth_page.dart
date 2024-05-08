import 'package:dima/pages/login_or_register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class AuthPage extends StatelessWidget {
  static const routeName = '/';

  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            // User is logged in
            if (snapshot.hasData) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushReplacementNamed(context, HomePage.routeName);
              }); // Assuming you want to replace the current route

              return SizedBox(); // Return an empty widget (or a loading spinner) while the navigation is pending
            }
            // User is not logged in
            else {
              return LoginOrRegisterPage(); // Corrected class name based on your import
            }
          } else {
            // Return loading screen while the connection state is not active
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
