import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_groceries_app/app_assets.dart';
import 'package:online_groceries_app/app_color.dart';

import 'package:online_groceries_app/controller/account_controller.dart';

import 'package:get/get.dart';

class AccountScreen extends GetView<AccountController> {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            decoration: BoxDecoration(color: AppColor.white),
            child: Row(
              children: [
                SizedBox(height: 30.h),
                CircleAvatar(
                  backgroundImage: AssetImage(AppAssets.icAvatar),
                  radius: 40,
                ),

                SizedBox(width: 15.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // Canh trái

                  children: [
                    Row(
                      children: [
                        Text(
                          controller.userName.value,
                          style: TextStyle(
                            color: AppColor.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                          ),
                          softWrap: true,
                        ),
                        SizedBox(width: 10),
                        Icon(Icons.edit, color: AppColor.green),
                      ],
                    ),

                    Text(
                      controller.userEmail.value,
                      style: TextStyle(color: AppColor.black, fontSize: 12.sp),
                      softWrap: true,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(),
          itemOptionAccount(Icons.assignment_outlined, 'Orders'.tr),

          Divider(),
          itemOptionAccount(Icons.co_present_rounded, 'My Details'.tr),

          Divider(),
          itemOptionAccount(
            Icons.person_pin_circle_outlined,
            'Delivery Address'.tr,
          ),

          Divider(),
          itemOptionAccount(Icons.payment_outlined, 'Payment Methods'.tr),

          Divider(),
          itemOptionAccount(Icons.discount_outlined, 'Promo Cord'.tr),

          Divider(),
          itemOptionAccount(
            Icons.notifications_active_outlined,
            'Notifecations'.tr,
          ),

          Divider(),
          itemOptionAccount(Icons.help_outline_sharp, 'Help'.tr),

          Divider(),
          itemOptionAccount(Icons.warning_rounded, "About".tr),
          Divider(),
          // itemOptionAccount(Icons.settings, "Setting".tr),
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text(
              "Setting".tr,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Get.bottomSheet(
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Chọn ngôn ngữ",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ListTile(
                        title: const Text("Tiếng Việt"),
                        onTap: () {
                          Get.updateLocale(const Locale('vi', 'VN'));
                          Get.back();
                        },
                      ),
                      ListTile(
                        title: const Text("English"),
                        onTap: () {
                          Get.updateLocale(const Locale('en', 'US'));
                          Get.back();
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          Divider(),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: GestureDetector(
              onTap: () {
                controller.logOut(context);
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.exit_to_app, color: AppColor.green),

                    SizedBox(width: 90.w),
                    Text(
                      'Log Out'.tr,
                      style: TextStyle(color: AppColor.green, fontSize: 16.sp),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget itemOptionAccount(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
      ),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: () {},
    );
  }
}
