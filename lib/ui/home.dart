import 'package:flutter/material.dart';
import 'package:online_groceries_app/app_color.dart';
import 'package:online_groceries_app/app_assets.dart';
import 'package:online_groceries_app/ui/onbording.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Onbording()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColor.green,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                width: 70,
                height: 70,
                AppAssets.icCarot,
                fit: BoxFit.contain,
              ),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'necta',
                    style: TextStyle(
                      fontSize: 35,
                      color: AppColor.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    'online groceriet',
                    style: TextStyle(fontSize: 12, color: AppColor.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
