import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:online_groceries_app/app_assets.dart';
import 'package:online_groceries_app/app_color.dart';
import 'package:online_groceries_app/ui/password_field.dart';
import 'package:flutter/gestures.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});
  @override
  State<SignUp> createState() => _SingUpState();
}

class _SingUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
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
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: AppColor.black,
                  ),
                ),

                Text(
                  'Enter your credentials to continue',
                  style: TextStyle(fontSize: 15, color: AppColor.gray),
                ),

                TextField(
                  decoration: InputDecoration(
                    labelText: 'Use Name',
                    border: UnderlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text,
                ),

                TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: UnderlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                PasswordField(),
                SizedBox(height: 20),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'By continuing you agree to our ',
                        style: TextStyle(fontSize: 20, color: AppColor.gray),
                      ),
                      TextSpan(
                        text: 'Terms of Service ',
                        style: TextStyle(fontSize: 20, color: AppColor.green),
                      ),
                      TextSpan(
                        text: 'and ',
                        style: TextStyle(fontSize: 20, color: AppColor.gray),
                      ),
                      TextSpan(
                        text: 'Pricacy ',
                        style: TextStyle(fontSize: 20, color: AppColor.green),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 30),
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
                        "Sing Up ",
                        style: TextStyle(fontSize: 18, color: AppColor.white),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 30),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Already have an account? ',
                            style: TextStyle(
                              fontSize: 20,
                              color: AppColor.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: ' Signup',
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
