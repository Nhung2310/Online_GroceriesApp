import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:online_groceries_app/app_assets.dart';
import 'package:online_groceries_app/app_color.dart';
import 'package:online_groceries_app/services/auth_service.dart';
import 'package:online_groceries_app/ui/email_field_check.dart';
import 'package:online_groceries_app/ui/password_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_groceries_app/widget/loading_dialog.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});
  @override
  State<SignUp> createState() => _SingUpState();
}

class _SingUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Form(
              key: _formKey,

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
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 25.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColor.black,
                    ),
                  ),

                  Text(
                    'Enter your credentials to continue',
                    style: TextStyle(fontSize: 15.sp, color: AppColor.gray),
                  ),

                  TextFormField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      labelText: 'Use Name',
                      border: UnderlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Tên không được để trống';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 10.h),
                  // TextField(
                  //   decoration: InputDecoration(
                  //     labelText: 'Email',
                  //     border: UnderlineInputBorder(),
                  //   ),
                  //   keyboardType: TextInputType.emailAddress,
                  // ),
                  EmailFieldWithCheck(controller: emailController),
                  SizedBox(height: 10.h),
                  PasswordField(controller: passwordController),
                  SizedBox(height: 20.h),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'By continuing you agree to our ',
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: AppColor.gray,
                          ),
                        ),
                        TextSpan(
                          text: 'Terms of Service ',
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: AppColor.green,
                          ),
                        ),
                        TextSpan(
                          text: 'and ',
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: AppColor.gray,
                          ),
                        ),
                        TextSpan(
                          text: 'Pricacy ',
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
                          if (_formKey.currentState!.validate()) {
                            //
                            //setState(() => isLoading = true);
                            showLoadingDialog(context);
                            final error = await AuthService.sign_up(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                              username: usernameController.text.trim(),
                            );
                            // setState(() => isLoading = false);
                            LoadingDialog(context);
                            if (error == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Bạn đã đăng ký thành công"),
                                ),
                              );
                              Navigator.pop(context);
                            } else {
                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(SnackBar(content: Text(error)));
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 15.h),
                          backgroundColor: AppColor.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child:
                            isLoading
                                ? SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: AppColor.green,
                                  ),
                                )
                                : Text(
                                  "Sing Up ",
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
                              text: 'Already have an account? ',
                              style: TextStyle(
                                fontSize: 20.sp,
                                color: AppColor.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: ' Signup',
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
      ),
    );
  }

  // Future<void> signUp() async {
  //   final username = usernameController.text.trim();
  //   final email = emailController.text.trim();
  //   final password = passwordController.text.trim();

  //   if (username.isEmpty || email.isEmpty || password.isEmpty) {
  //     ScaffoldMessenger.of(
  //       context,
  //     ).showSnackBar(SnackBar(content: Text("Vui lòng điền đầy đủ thông tin")));
  //     return;
  //   }
  //   try {
  //     final userCredential = await FirebaseAuth.instance
  //         .createUserWithEmailAndPassword(email: email, password: password);
  //     await userCredential.user!.updateDisplayName(username);

  //     ScaffoldMessenger.of(
  //       context,
  //     ).showSnackBar(SnackBar(content: Text("Đăng ký thành công!")));
  //     Navigator.pop(context);
  //   } on FirebaseAuthException catch (e) {
  //     String msg = '';
  //     if (e.code == 'email-already-in-use') {
  //       msg = 'Email đã được đăng ký, vui lòng chọn email khác';
  //     } else if (e.code == 'weak-password') {
  //       msg = 'Mật khẩu quá yếu vui lòng đặt mật khẩu mạnh hơn >=6 ký tự';
  //     } else {
  //       msg = e.message ?? 'Lỗi không xác định';
  //     }
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  //   }
  // }
}
