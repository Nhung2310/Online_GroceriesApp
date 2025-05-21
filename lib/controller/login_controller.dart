import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_groceries_app/app_routes_name.dart';
import 'package:online_groceries_app/services/auth_service.dart';
import 'package:online_groceries_app/widget/error_dialog.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> onclickLogin(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      final errorLogin = await AuthService.logInAndCheckVerifyEmai(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        context: context,
      );

      if (errorLogin == null) {
        Get.offAllNamed(AppRoutesName.home);
      } else if (errorLogin == 'email-not-verified') {
        Get.offAllNamed(
          AppRoutesName.emailVerified,
          arguments: emailController.text.trim(),
        );
      } else {
        showErrorDialog(context, errorLogin);
      }
    }
  }
}
