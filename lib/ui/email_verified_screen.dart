import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_groceries_app/app_assets.dart';
import 'package:online_groceries_app/app_color.dart';
import 'package:online_groceries_app/ui/home_screen.dart';
import 'package:online_groceries_app/ui/splash_screen.dart';
import 'package:online_groceries_app/ui/log_in_screen.dart';

class EmailVerifiedScreen extends StatefulWidget {
  final String email;
  const EmailVerifiedScreen({super.key, required this.email});
  @override
  State<EmailVerifiedScreen> createState() => _EmailVerifiedScreenState();
}

class _EmailVerifiedScreenState extends State<EmailVerifiedScreen> {
  late Timer _timer;
  int _countdownTime = 30;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkEmailVerifiedAndRedirect();
    startCountDown();
  }

  Future<void> sendEmailVerification() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please check your email to confirm your account!'),
        ),
      );
    }
  }

  Future<void> checkEmailVerifiedAndRedirect() async {
    Timer.periodic(Duration(seconds: 1), (timer) async {
      User? user = FirebaseAuth.instance.currentUser;
      await user?.reload();
      if (!mounted) return;

      if (user != null && user.emailVerified) {
        timer.cancel();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      }
    });
  }

  void startCountDown() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_countdownTime == 0) {
        _timer.cancel();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      } else {
        setState(() {
          _countdownTime--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                '"Confirm',
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
                  TextSpan(text: 'We have sent an email to '),
                  TextSpan(
                    text: '${widget.email}',
                    style: TextStyle(color: AppColor.black),
                  ),
                  TextSpan(
                    text: ' with a link to access your account.',
                  ), // Phần còn lại của văn bản
                ],
              ),
            ),

            SizedBox(height: 20.h),
            Center(
              child: SizedBox(
                width: 200.w,

                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15.h),
                    backgroundColor: AppColor.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                  ),
                  child: Text(
                    'Cancel  ($_countdownTime)',
                    style: TextStyle(fontSize: 18.sp, color: AppColor.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
