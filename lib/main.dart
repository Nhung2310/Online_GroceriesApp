import 'package:flutter/material.dart';
import 'package:online_groceries_app/ui/onbording.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Onbording(),
      debugShowCheckedModeBanner: false,
    );
  }
}
