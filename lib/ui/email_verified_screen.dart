import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:online_groceries_app/app_assets.dart';
import 'package:online_groceries_app/app_color.dart';
import 'package:online_groceries_app/app_routes_name.dart';
import 'package:online_groceries_app/controller/email_verified_controller.dart';
import 'package:get/get.dart';

class EmailVerifiedScreen extends GetView<EmailVerifiedController> {
  @override
  Widget build(BuildContext context) {
    final String email = Get.arguments ?? 'your email';
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 150.h),
            Center(
              child: Image.asset(
                width: 150.w,
                height: 150.h,
                AppAssets.icEmail,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 50.h),
            Center(
              child: Text(
                'Confirm'.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColor.black,
                ),
              ),
            ),

            SizedBox(height: 50.h),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColor.gray,
                ),
                children: [
                  TextSpan(text: 'We have sent an email to '.tr),
                  TextSpan(
                    text: email,
                    style: TextStyle(color: AppColor.black),
                  ),
                  TextSpan(text: ' with a link to access your account.'.tr),
                ],
              ),
            ),

            SizedBox(height: 20.h),
            buildCancelButton(),
          ],
        ),
      ),
    );
  }

  Widget buildCancelButton() {
    return Center(
      child: SizedBox(
        width: 200.w,

        child: ElevatedButton(
          onPressed: () {
            Get.offAllNamed(AppRoutesName.login);
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 15.h),
            backgroundColor: AppColor.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.r),
            ),
          ),
          child: Text(
            'Cancel '.tr,
            style: TextStyle(fontSize: 18.sp, color: AppColor.white),
          ),
        ),
      ),
    );
  }
}
