import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online_groceries_app/app_assets.dart';
import 'package:online_groceries_app/app_color.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateAfterDelay();
  }

  Future<void> _navigateAfterDelay() async {
    await Future.delayed(const Duration(seconds: 2));

    final prefs = await SharedPreferences.getInstance();
    final hasSeenOnboarding = prefs.getBool('has_seen_onboarding') ?? false;
    final isLoggedIn = FirebaseAuth.instance.currentUser != null;

    if (!hasSeenOnboarding) {
      prefs.setBool('has_seen_onboarding', true);
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => const Onbording()),
      // );
      Get.offAllNamed('/onbording');
    } else if (isLoggedIn) {
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => const HomeScreen()),
      // );
      Get.offAllNamed('/home');
    } else {
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => const Login()),
      // );
      Get.offAllNamed('/log_in');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColor.green,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppAssets.icCarot,
                width: 70,
                height: 70,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 8),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'necta',
                    style: TextStyle(
                      fontSize: 35,
                      color: AppColor.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'online groceries',
                    style: TextStyle(fontSize: 12, color: AppColor.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
