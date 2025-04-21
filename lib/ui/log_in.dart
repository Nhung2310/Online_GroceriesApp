import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:online_groceries_app/app_assets.dart';
import 'package:online_groceries_app/app_color.dart';
import 'package:online_groceries_app/ui/email_field_check.dart';
import 'package:online_groceries_app/ui/password_field.dart';
import 'package:online_groceries_app/ui/sign_up.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Future<void> singInWithEmail() async{
  //   final email =emailController.text.trim();
  //   final password=passwordController.text.trim();

  //   if( email.isEmpty || password.isEmpty){
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text("Email và mật khẩu không được để trống")),

  //     );
  //     return;
  //   }try{
  //     await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password)
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            //  padding: const EdgeInsets.symmetric(),
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

                // TextField(
                //   decoration: InputDecoration(
                //     labelText: 'Email',
                //     border: UnderlineInputBorder(),
                //   ),
                //   keyboardType: TextInputType.emailAddress,
                // ),
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
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15.h),
                        backgroundColor: AppColor.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        "Log in",
                        style: TextStyle(fontSize: 18.sp, color: Colors.white),
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
    );
  }
}
