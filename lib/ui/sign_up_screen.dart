import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:online_groceries_app/app_assets.dart';
import 'package:online_groceries_app/app_color.dart';
import 'package:online_groceries_app/app_routes_name.dart';
import 'package:online_groceries_app/controller/sign_up_controller.dart';

import 'package:online_groceries_app/widget/email_field_check.dart';

import 'package:online_groceries_app/widget/password_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

class SignUp extends GetView<SignUpController> {
  const SignUp({super.key});

  // final _formKey = GlobalKey<FormState>();
  // final TextEditingController usernameController = TextEditingController();
  // final TextEditingController emailController = TextEditingController();
  // final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Form(
              key: controller.formKey,

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
                    'Sign Up'.tr,
                    style: TextStyle(
                      fontSize: 25.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColor.black,
                    ),
                  ),

                  Text(
                    'Enter your credentials to continue'.tr,
                    style: TextStyle(fontSize: 15.sp, color: AppColor.gray),
                  ),

                  TextFormField(
                    controller: controller.usernameController,
                    decoration: InputDecoration(
                      labelText: 'Use Name'.tr,
                      border: UnderlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'The name field cannot be empty.'.tr;
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 10.h),

                  EmailFieldWithCheck(controller: controller.emailController),
                  SizedBox(height: 10.h),
                  PasswordField(controller: controller.passwordController),
                  SizedBox(height: 20.h),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'By continuing you agree to our '.tr,
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: AppColor.gray,
                          ),
                        ),
                        TextSpan(
                          text: 'Terms of Service '.tr,
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: AppColor.green,
                          ),
                        ),
                        TextSpan(
                          text: 'and '.tr,
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: AppColor.gray,
                          ),
                        ),
                        TextSpan(
                          text: 'Pricacy '.tr,
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: AppColor.green,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 30.h),
                  Center(
                    child: SizedBox(
                      width: 300.w,
                      child: ElevatedButton(
                        onPressed: () async {
                          await controller.onclickSignUp(context);
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 15.h),
                          backgroundColor: AppColor.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          "Sign Up ".tr,
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: AppColor.white,
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
                              text: 'Already have an account? '.tr,
                              style: TextStyle(
                                fontSize: 20.sp,
                                color: AppColor.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: ' Signup'.tr,
                              style: TextStyle(
                                fontSize: 20.sp,
                                color: AppColor.green,
                              ),

                              recognizer:
                                  TapGestureRecognizer()
                                    ..onTap = () {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) => SignUp(),
                                      //   ),
                                      // );
                                      Get.offAllNamed(AppRoutesName.signUp);
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
}
