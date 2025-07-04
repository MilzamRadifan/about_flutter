import 'package:event_management_app/Screen/widget/button_widget.dart';
import 'package:event_management_app/Service/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String email = "";
  
  @override
  void initState() {
    super.initState();
    // ambil data user dari firebase. jika tidk ada, alihkan ke halaman sign in
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.pushReplacementNamed(context, '/signin');
      } else {
        setState(() {
          email = user.email ?? "";
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.grey,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),

          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Hello, $email",
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ), 
                const Spacer(),
                ButtonWidget(
                  title: "Sign Out",
                  height: 30,
                  width: 100,
                  ontap: () async {
                    await Authservice().signOut(context: context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
