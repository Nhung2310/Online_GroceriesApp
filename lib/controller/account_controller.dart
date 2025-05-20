import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_groceries_app/app_routes_name.dart';
import 'package:online_groceries_app/widget/loading_dialog.dart';

class AccountController extends GetxController {
  final RxString userName = ''.obs;
  final RxString userEmail = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getUserInfo();
  }

  Future<void> getUserInfo() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      userName.value = user.displayName ?? "No Name";
      userEmail.value = user.email ?? "No Email";
    } else {
      userName.value = " ";
      userEmail.value = " ";
    }
  }

  Future<void> logOut(BuildContext context) async {
    try {
      showLoadingDialog(context);
      await FirebaseAuth.instance.signOut();
      dismissDialog(context);
      Get.offAllNamed(AppRoutesName.login);
    } catch (e) {
      dismissDialog(context);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Logout failed: $e')));
    }
  }
}
