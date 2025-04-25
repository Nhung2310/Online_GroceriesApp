import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_groceries_app/app_assets.dart';
import 'package:online_groceries_app/app_color.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:online_groceries_app/controller/product_controller.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});
  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final ProductController productController = Get.put(ProductController());

  TextEditingController searchController = TextEditingController();
  bool isSeeAll = false;
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.location_on, color: AppColor.gray, size: 20.sp),
                    Text(
                      'HCM, Vietnam',
                      style: TextStyle(color: AppColor.black, fontSize: 16.sp),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search Store',
                  hintStyle: TextStyle(color: AppColor.gray, fontSize: 14.sp),
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppColor.black,
                    size: 20.sp,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10.h,
                    horizontal: 15.w,
                  ),
                  filled: true,
                  fillColor: AppColor.graysearch,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.r),
                    borderSide: BorderSide(
                      color: AppColor.graysearch,
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.r),
                    borderSide: BorderSide(
                      color: AppColor.graysearch,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.r),
                    borderSide: BorderSide(
                      color: AppColor.graysearch,
                      width: 1,
                    ),
                  ),
                ),
                style: TextStyle(fontSize: 14.sp, color: AppColor.black),
              ),
              SizedBox(height: 20.h),

              SizedBox(
                height: 200.h,
                width: 1.sw,
                child: CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: 20 / 9,
                    viewportFraction: 1.0,
                  ),
                  items: [
                    itemContainer(AppAssets.vegetables),
                    itemContainer(AppAssets.vegetables),
                    itemContainer(AppAssets.vegetables),
                  ],
                ),
              ),
              SizedBox(height: 30.h),
              text('Exclusive Offer'),

              Obx(() {
                if (productController.exclusiveOfferProducts.isEmpty) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 20.w,
                      mainAxisSpacing: 20.h,
                    ),

                    itemCount:
                        productController.groceriesProducts.length > 2
                            ? 2
                            : productController.groceriesProducts.length,

                    itemBuilder: (context, index) {
                      final product =
                          productController.exclusiveOfferProducts[index];
                      return Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          side: BorderSide(
                            color: AppColor.graysearch,
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(12.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Image.network(
                                  product.image,
                                  height: 90.h,
                                  width: 90.w,
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(Icons.error, size: 50.sp);
                                  },
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Text(
                                product.title,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.black,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                product.unitPrice,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: AppColor.gray,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 10.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '\$${product.price.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.black,
                                    ),
                                  ),
                                  Container(
                                    width: 36.w,
                                    height: 36.h,
                                    decoration: BoxDecoration(
                                      color: AppColor.green,
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      color: AppColor.white,
                                      size: 20.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              }),
              SizedBox(height: 30.h),
              text('Best Selling'),

              Obx(() {
                if (productController.bestSellingProducts.isEmpty) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 20.w,
                      mainAxisSpacing: 20.h,
                    ),
                    itemCount:
                        productController.bestSellingProducts.length > 2
                            ? 2
                            : productController.bestSellingProducts.length,
                    //itemCount: productController.bestSellingProducts.length,
                    itemBuilder: (context, index) {
                      final product =
                          productController.bestSellingProducts[index];
                      return Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          side: BorderSide(
                            color: AppColor.graysearch,
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(12.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Image.network(
                                  product.image,
                                  height: 90.h,
                                  width: 90.w,
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(Icons.error, size: 50.sp);
                                  },
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Text(
                                product.title,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.black,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                product.unitPrice,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: AppColor.gray,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 10.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '\$${product.price.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.black,
                                    ),
                                  ),
                                  Container(
                                    width: 36.w,
                                    height: 36.h,
                                    decoration: BoxDecoration(
                                      color: AppColor.green,
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      color: AppColor.white,
                                      size: 20.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              }),
              SizedBox(height: 30.h),
              text('Groceries'),

              Obx(() {
                if (productController.groceriesProducts.isEmpty) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 20.w,
                      mainAxisSpacing: 20.h,
                    ),
                    itemCount:
                        productController.groceriesProducts.length > 2
                            ? 2
                            : productController.groceriesProducts.length,
                    itemBuilder: (context, index) {
                      final product =
                          productController.groceriesProducts[index];
                      return Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          side: BorderSide(
                            color: AppColor.graysearch,
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(12.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Image.network(
                                  product.image,
                                  height: 90.h,
                                  width: 90.w,
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(Icons.error, size: 50.sp);
                                  },
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Text(
                                product.title,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.black,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                product.unitPrice,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: AppColor.gray,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 10.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '\$${product.price.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.black,
                                    ),
                                  ),
                                  Container(
                                    width: 36.w,
                                    height: 36.h,
                                    decoration: BoxDecoration(
                                      color: AppColor.green,
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      color: AppColor.white,
                                      size: 20.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget itemContainer(String image) {
    return Container(
      color: AppColor.green,
      child: Center(
        child: Image.asset(
          image,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget text(String text) {
    return Row(
      children: [
        Text(
          text,
          style: TextStyle(
            color: AppColor.black,
            fontWeight: FontWeight.bold,
            fontSize: 15.sp,
          ),
        ),
        Spacer(),

        Text(
          'See all',
          style: TextStyle(color: AppColor.green, fontSize: 14.sp),
        ),
      ],
    );
  }
}
