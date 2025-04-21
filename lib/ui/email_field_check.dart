import 'package:flutter/material.dart';
import 'package:online_groceries_app/app_color.dart';

class EmailFieldWithCheck extends StatefulWidget {
  final TextEditingController controller;

  const EmailFieldWithCheck({super.key, required this.controller});

  @override
  State<EmailFieldWithCheck> createState() => _EmailFieldWithCheckState();
}

class _EmailFieldWithCheckState extends State<EmailFieldWithCheck> {
  //final TextEditingController _emailController = TextEditingController();
  bool _isValidEmail = false;

  // Regex kiểm tra định dạng email
  bool isEmailValid(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      setState(() {
        _isValidEmail = isEmailValid(widget.controller.text);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email',
        border: const UnderlineInputBorder(),
        suffixIcon:
            _isValidEmail
                ? const Icon(Icons.check, color: AppColor.green)
                : null,
      ),
    );
  }
}
