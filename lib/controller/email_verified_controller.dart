import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:online_groceries_app/app_routes_name.dart';

class EmailVerifiedController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    checkEmailVerifiedAndRedirect();
  }

  Future<void> sendEmailVerification() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
      Get.snackbar('Error', 'Please check your email to confirm your account!');
    }
  }

  Future<void> checkEmailVerifiedAndRedirect() async {
    Timer.periodic(Duration(seconds: 1), (timer) async {
      User? user = FirebaseAuth.instance.currentUser;
      await user?.reload();
      if (user != null && user.emailVerified) {
        timer.cancel();
        Get.offAllNamed(AppRoutesName.home);
      }
    });
  }
}
