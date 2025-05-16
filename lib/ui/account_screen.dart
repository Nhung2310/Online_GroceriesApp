import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_groceries_app/app_assets.dart';
import 'package:online_groceries_app/app_color.dart';
import 'package:online_groceries_app/ui/log_in_screen.dart';
import 'package:online_groceries_app/widget/loading_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String userName = '';
  String userEmail = '';

  void initState() {
    super.initState();
    _getUserInfo();
  }

  Future<void> _getUserInfo() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        userName = user.displayName ?? "No Name";
        userEmail = user.email ?? "No Email";
      });
    } else {
      setState(() {
        userName = " ";
        userEmail = " ";
      });
    }
  }

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
                          userName,
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
                      userEmail,
                      style: TextStyle(color: AppColor.black, fontSize: 12.sp),
                      softWrap: true,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(),
          itemOptionAccount(Icons.assignment_outlined, 'Orders'),

          Divider(),
          itemOptionAccount(Icons.co_present_rounded, 'My Details'),

          Divider(),
          itemOptionAccount(
            Icons.person_pin_circle_outlined,
            'Delivery Address',
          ),

          Divider(),
          itemOptionAccount(Icons.payment_outlined, 'Payment Methods'),

          Divider(),
          itemOptionAccount(Icons.discount_outlined, 'Promo Cord'),

          Divider(),
          itemOptionAccount(
            Icons.notifications_active_outlined,
            'Notifecations',
          ),

          Divider(),
          itemOptionAccount(Icons.help_outline_sharp, 'Help'),

          Divider(),
          itemOptionAccount(Icons.warning_rounded, "About"),

          Divider(),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: GestureDetector(
              onTap: () {
                logOut(context);
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
                      'Log Out',
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

  Future<void> logOut(BuildContext context) async {
    try {
      showLoadingDialog(context);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('is_logged_in', false);

      await FirebaseAuth.instance.signOut();
      dismissDialog(context);
      Get.offAllNamed('/login');
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => Login()),
      // );
    } catch (e) {
      print('Error while logging out: $e');

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Logout failed: $e')));
    }
  }
}
