import 'package:event_management_app/Screen/page/sign_in_page.dart';
import 'package:event_management_app/firebase_options.dart';
import 'package:event_management_app/Screen/page/home_page.dart';
import 'package:event_management_app/Screen/page/sign_up_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      ),
      home: const SignInPage(),
      routes: {
        '/home': (context) => const HomePage(),
        '/signup': (context) => const SignUpPage(),
        '/signin': (context) => const SignInPage(),
      },
    );
  }
}