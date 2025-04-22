import 'package:flutter/material.dart';
import 'package:online_groceries_app/firebase_options.dart';
import 'package:online_groceries_app/ui/onbording_screen.dart';
import 'package:online_groceries_app/ui/splash_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
          home: const SplashScreen(), //
        );
      },
    );

    // return MaterialApp(home: const Home(), debugShowCheckedModeBanner: false);
  }
}
