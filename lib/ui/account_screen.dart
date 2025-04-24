import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_groceries_app/app_assets.dart';
import 'package:online_groceries_app/app_color.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
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
                          'Trùm mafia',
                          style: TextStyle(
                            color: AppColor.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 10),
                        Icon(Icons.edit, color: AppColor.green),
                      ],
                    ),

                    Text(
                      '123sksk@gmail.com',
                      style: TextStyle(color: AppColor.black),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.assignment_outlined),
            title: Text(
              'Orders',
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
            ),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
          Divider(), // đường kẻ ngang giữa list
          ListTile(
            leading: Icon(Icons.co_present_rounded),
            title: Text(
              'My Details',
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
            ),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.person_pin_circle_outlined),
            title: Text(
              'Delivery Address',
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
            ),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment_outlined),
            title: Text(
              'Payment Methods',
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
            ),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.discount_outlined),
            title: Text(
              'Promo Cord',
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
            ),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.notifications_active_outlined),
            title: Text(
              'Notifecations',
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
            ),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
          Divider(),

          ListTile(
            leading: Icon(Icons.help_outline_sharp),
            title: Text(
              'Help',
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
            ),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
          Divider(),

          ListTile(
            leading: Icon(Icons.warning_rounded),
            title: Text(
              'About',
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
            ),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: GestureDetector(
              onTap: () {
                print("Logging out...");
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
}
