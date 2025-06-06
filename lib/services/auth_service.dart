import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online_groceries_app/widget/error_dialog.dart';

class AuthService {
  static Future<String?> signUp({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await userCredential.user!.updateDisplayName(username);
      await userCredential.user!.sendEmailVerification();
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return 'This email address is already registered. Please choose another email.';
      } else if (e.code == 'weak-password') {
        return 'Password is too weak (minimum 6 characters).';
      } else {
        return e.message ?? 'An unknown error occurred. Please wait a moment.';
      }
    }
  }

  static Future<String?> logInAndCheckVerifyEmai({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null && !userCredential.user!.emailVerified) {
        showErrorDialog(context, 'Please verify your email before logging in.');
        return 'Please verify your email before logging in.';
      }

      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'Account does not exist.';
      } else if (e.code == 'wrong-password') {
        return 'Incorrect password.';
      } else {
        return e.message ?? 'An unknown error occurred. Please wait a moment.';
      }
    }
  }

  static Future<String?> logIn({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'Account does not exist.';
      } else if (e.code == 'wrong-password') {
        return 'Incorrect password.';
      } else {
        return e.message ?? 'An unknown error occurred. Please wait a moment.';
      }
    }
  }
}
