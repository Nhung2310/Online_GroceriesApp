import 'package:flutter/material.dart';
import 'package:online_groceries_app/app_assets.dart';
import 'package:online_groceries_app/app_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_groceries_app/ui/checkout_screen.dart';
import 'package:online_groceries_app/ui/home_screen.dart';
import 'package:online_groceries_app/ui/shop_screen.dart';
import 'package:get/get.dart';

class OrderAccepted extends StatelessWidget {
  const OrderAccepted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 70.h, 20, 50),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 100.h),
              Image.asset(
                AppAssets.icCheck,
                width: 200,
                height: 200,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 50.h),
              Text(
                textAlign: TextAlign.center,
                'Your Order has been accepted',
                style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.h),
              Text(
                textAlign: TextAlign.center,
                'Your items has been placcd and is on it’s way to being processed',
                style: TextStyle(color: AppColor.gray, fontSize: 16.sp),
              ),
              SizedBox(height: 50.h),
              Center(
                child: SizedBox(
                  width: 300.w,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15.h),
                      backgroundColor: AppColor.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'Track Order',
                      style: TextStyle(fontSize: 14.sp, color: AppColor.white),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              Center(
                child: SizedBox(
                  width: 300.w,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.off(() => HomeScreen());
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15.h),
                      backgroundColor: AppColor.graysearch,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'Back to home',
                      style: TextStyle(fontSize: 14.sp, color: AppColor.black),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
