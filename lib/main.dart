import 'package:flutter/material.dart';
import 'package:online_groceries_app/ui/onbording.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: const Onbording(),
      debugShowCheckedModeBanner: false,
    );
  }
}
