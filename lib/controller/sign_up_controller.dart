import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_groceries_app/services/auth_service.dart';
import 'package:online_groceries_app/widget/error_dialog.dart';
import 'package:online_groceries_app/widget/loading_dialog.dart';

class SignUpController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void onClose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> onclickLogin(BuildContext context) async {
    final errorlogin = await AuthService.logIn(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
  }

  Future<void> onclickSignUp(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      showLoadingDialog(context);
      final error = await AuthService.signUp(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        username: usernameController.text.trim(),
      );
      // setState(() => isLoading = false);
      dismissDialog(context);
      if (error == null) {
        //await sendVerificationEmail(context);
        onclickLogin(context);
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder:
        //         (context) =>
        //             EmailVerifiedScreen(email: emailController.text.trim()),
        //   ),
        // );
        Get.offAllNamed(
          '/email_verified',
          arguments: emailController.text.trim(),
        );
      } else {
        showErrorDialog(context, error);
        // ScaffoldMessenger.of(
        //   context,
        // ).showSnackBar(SnackBar(content: Text(error)));
      }
    }
  }
}
