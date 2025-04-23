import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:online_groceries_app/app_assets.dart';
import 'package:online_groceries_app/app_color.dart';
import 'package:online_groceries_app/services/auth_service.dart';
import 'package:online_groceries_app/ui/email_field_check.dart';
import 'package:online_groceries_app/ui/home_screen.dart';
import 'package:online_groceries_app/ui/password_field.dart';
import 'package:online_groceries_app/ui/sign_up_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_groceries_app/widget/error_dialog.dart';
import 'package:online_groceries_app/widget/loading_dialog.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            //  padding: const EdgeInsets.symmetric(),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 50.h),
                  Center(
                    child: Image.asset(
                      width: 50.w,
                      height: 50.h,
                      AppAssets.icCarotRed,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 50.h),
                  Text(
                    'Loging',
                    style: TextStyle(
                      fontSize: 25.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColor.black,
                    ),
                  ),

                  Text(
                    'Entern your email and password',
                    style: TextStyle(fontSize: 15.sp, color: AppColor.gray),
                  ),

                  SizedBox(height: 10.h),

                  EmailFieldWithCheck(controller: emailController),
                  SizedBox(height: 10.h),
                  PasswordField(controller: passwordController),
                  SizedBox(height: 10.h),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(fontSize: 13.sp, color: AppColor.gray),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Center(
                    child: SizedBox(
                      width: 300.w,

                      child: ElevatedButton(
                        onPressed: () async {
                          await onclickLogin(context);
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 15.h),
                          backgroundColor: AppColor.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          "Log in",
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 20.h),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Don’t have an account? ',
                              style: TextStyle(
                                fontSize: 20.sp,
                                color: AppColor.gray,
                              ),
                            ),
                            TextSpan(
                              text: 'Singup',
                              style: TextStyle(
                                fontSize: 20.sp,
                                color: AppColor.green,
                              ),

                              recognizer:
                                  TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SignUp(),
                                        ),
                                      );
                                    },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onclickLogin(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      showLoadingDialog(context);
      dismissDialog(context);
      final error = await AuthService.logInAndCheckVerifyEmai(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        context: context,
      );
      //dismissDialog(context);
      if (error == null) {
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) => HomeScreen()),
        // );

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
          (Route<dynamic> route) => false,
        );
      } else {
        showErrorDialog(context, error);
      }
    }
  }
}
