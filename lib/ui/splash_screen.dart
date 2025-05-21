import 'package:flutter/material.dart';
import 'package:online_groceries_app/app_assets.dart';
import 'package:online_groceries_app/app_color.dart';

import 'package:get/get.dart';
import 'package:online_groceries_app/controller/splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Future.microtask(() => controller.navigateAfterDelay());
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
