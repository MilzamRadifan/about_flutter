import 'package:event_management_app/Screen/page/event_page.dart';
import 'package:event_management_app/Screen/page/local_notification_page.dart';
import 'package:event_management_app/Screen/page/remote_notification_page.dart';
import 'package:event_management_app/Screen/page/sign_in_page.dart';
import 'package:event_management_app/Service/local_notification_service.dart';
import 'package:event_management_app/Service/remote_notification_service.dart';
import 'package:event_management_app/firebase_options.dart';
import 'package:event_management_app/Screen/page/home_page.dart';
import 'package:event_management_app/Screen/page/sign_up_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  await RemoteNotificationService().init();

  await LocalNotificationService().initNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: ThemeData(
      ),
      home: const SignInPage(),
      routes: {
        '/home': (context) => const HomePage(),
        '/signup': (context) => const SignUpPage(),
        '/signin': (context) => const SignInPage(),
        '/event': (context) => const EventPage(),
        '/remote-notification': (context) => const RemoteNotificationPage(),
        '/local-notification': (context) => const LocalNotificationPage(),
      },
    );
  }
}