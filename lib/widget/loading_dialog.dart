import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:online_groceries_app/app_color.dart';

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: AppColor.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 20),
              Text(
                "Chờ xíu nha...",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      );
    },
  );
}

void dismissDialog(BuildContext context) {
  Navigator.of(context, rootNavigator: true).pop();
}
