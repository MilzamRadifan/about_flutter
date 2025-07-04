import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Authservice {
  
  //* Sign up
  Future<void> signUp({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // jika berhasil,navigasi ke sign in page
      await Future.delayed(const Duration(seconds: 2));
      Navigator.pushReplacementNamed(context, '/signin');

    } on FirebaseException catch (e) {
      String message = "";
      if (e.code == 'email-already-in-use') {
        message = "Email already in use";
      } else if (e.code == 'invalid-email') {
        message = "Invalid email address";
      } else if (e.code == 'weak-password') {
        message = "Weak password";
      } else {
        message = e.toString();
      }
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 12.0,
      );
    } catch (e) {
      print(e.toString());
    }
  }

  //* Sign in
  Future<void> signIn({
    required String email, 
    required String password,
    required BuildContext context,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // jika berhasil, navigasi ke home page
      await Future.delayed(const Duration(seconds: 2));
      Navigator.pushReplacementNamed(context, '/home');

    } on FirebaseException catch (e) {
      String message = "";
      if (e.code == 'user-not-found') {
        message = "User not found";
      } else if (e.code == 'invalid-email') {
        message = "Invalid email address";
      } else if (e.code == 'wrong-password') {
        message = "Wrong password";
      } else {
        message = e.toString();
      }
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (e) {
      print(e);
    }
  }

  //* Sign Out
  Future<void> signOut({
    required BuildContext context,
  }) async {
    try {
      await FirebaseAuth.instance.signOut();
      await Future.delayed(const Duration(seconds: 2));
      Navigator.pushReplacementNamed(context, '/signin');
    } catch (e) {
      print(e);
    }
  }
}
