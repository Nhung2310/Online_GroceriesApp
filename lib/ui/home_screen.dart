import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_groceries_app/app_assets.dart';
import 'package:online_groceries_app/app_color.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
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
              SizedBox(height: 20.h),
              Center(
                child: Row(
                  children: [
                    Icon(Icons.location_on, color: AppColor.gray, size: 20.sp),
                    Text(
                      'HCM, Vietnam',
                      style: TextStyle(color: AppColor.black, fontSize: 16.sp),
                    ),
                  ],
                ),
              ),
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  labelText: 'Search Store',
                  prefixIcon: Icon(Icons.search),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.r),
                    borderSide: BorderSide(color: AppColor.gray, width: 2),
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 16 / 9,
                  viewportFraction: 1.0,
                ),
                items: [
                  //slider1
                  Container(
                    color: AppColor.green,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            width: 150,
                            height: 150,
                            AppAssets.vegetables,
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(
                    color: AppColor.green,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppAssets.vegetables,
                            width: 150,
                            height: 150,
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(
                    color: AppColor.green,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppAssets.vegetables,
                            height: 150,
                            width: 150,
                          ),
                        ],
                      ),
                    ),
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
