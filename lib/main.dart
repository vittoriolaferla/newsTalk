import 'package:dima/pages/home_page.dart';
import 'package:dima/pages/auth_page.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'managers/article_notifier.dart';
import 'firebase_options.dart';

List<String> nameCategories = [
  'general',
  'sports',
  'entertainment',
  'health',
  'business',
  'technology'
];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  runApp(ChangeNotifierProvider(
      create: (context) => ArticleProvider(), child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const AuthPage(), // Map the '/' route to AuthPage
        HomePage.routeName: (context) => const HomePage(),
        // Add other routes here
      },
    );
  }
}
