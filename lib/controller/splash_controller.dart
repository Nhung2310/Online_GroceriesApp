import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:online_groceries_app/app_routes_name.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    navigateAfterDelay();
  }

  Future<void> navigateAfterDelay() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      final prefs = await SharedPreferences.getInstance();
      final hasSeenOnboarding = prefs.getBool('has_seen_onboarding') ?? false;
      final isLoggedIn = FirebaseAuth.instance.currentUser != null;

      if (!hasSeenOnboarding) {
        await prefs.setBool('has_seen_onboarding', true);
        Get.offAllNamed(AppRoutesName.onbording);
      } else if (isLoggedIn) {
        User? user = FirebaseAuth.instance.currentUser;
        await user?.reload();
        if (user != null && user.emailVerified) {
          Get.offAllNamed(AppRoutesName.home);
        } else {
          await FirebaseAuth.instance.signOut();
          Get.offAllNamed(AppRoutesName.login);
        }
      } else {
        Get.offAllNamed(AppRoutesName.login);
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e');
      Get.offAllNamed(AppRoutesName.login); // Fallback to login
    }
  }
}
