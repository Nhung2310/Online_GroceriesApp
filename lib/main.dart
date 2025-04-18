import 'package:flutter/material.dart';
import 'package:online_groceries_app/ui/onbording.dart';
import 'package:online_groceries_app/ui/home.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return ScreenUtilInit(
      designSize: Size(414, 896),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const Home(), //
        );
      },
    );

    // return MaterialApp(home: const Home(), debugShowCheckedModeBanner: false);
  }
}
