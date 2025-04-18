import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:online_groceries_app/app_assets.dart';
import 'package:online_groceries_app/app_color.dart';
import 'package:online_groceries_app/ui/email_field_check.dart';
import 'package:online_groceries_app/ui/password_field.dart';
import 'package:online_groceries_app/ui/sign_up.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            //  padding: const EdgeInsets.symmetric(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 50),
                Center(
                  child: Image.asset(
                    width: 50,
                    height: 50,
                    AppAssets.icCarotRed,
                    fit: BoxFit.contain,
                  ),
                ),

                Text(
                  'Loging',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: AppColor.black,
                  ),
                ),

                Text(
                  'Entern your email and password',
                  style: TextStyle(fontSize: 15, color: AppColor.gray),
                ),

                // TextField(
                //   decoration: InputDecoration(
                //     labelText: 'Email',
                //     border: UnderlineInputBorder(),
                //   ),
                //   keyboardType: TextInputType.emailAddress,
                // ),
                EmailFieldWithCheck(),
                PasswordField(),
                SizedBox(width: 30),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(fontSize: 13, color: AppColor.gray),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: SizedBox(
                    width: 300,

                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        backgroundColor: AppColor.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        "Log in",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Don’t have an account? ',
                            style: TextStyle(
                              fontSize: 20,
                              color: AppColor.gray,
                            ),
                          ),
                          TextSpan(
                            text: 'Singup',
                            style: TextStyle(
                              fontSize: 20,
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
