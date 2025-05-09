import 'package:flutter/material.dart';

import 'package:online_groceries_app/app_assets.dart';
import 'package:online_groceries_app/app_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:online_groceries_app/controller/explore_controller.dart';
import 'package:online_groceries_app/model/product.dart';
import 'package:online_groceries_app/ui/category_screen.dart';
import 'package:online_groceries_app/widget/error_dialog.dart';
import 'package:online_groceries_app/widget/loading_dialog.dart';
import 'package:get/get.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  TextEditingController searchController = TextEditingController();
  final ExploreController exploreController = Get.put(ExploreController());
  final List<Map<String, dynamic>> categories = [
    {
      'name': 'Frash Fruits & Vegetable',
      'color': const Color(0xFFE5F5E7),
      'img': AppAssets.icFrashFruitsVagetable,
    },
    {
      'name': 'Cooking Oil & Ghee',
      'color': const Color(0xFFFFF3E5),
      'img': AppAssets.icCookingOilGhee,
    },
    {
      'name': 'Meat & Fish',
      'color': const Color(0xFFFEE5E5),
      'img': AppAssets.icMeatFish,
    },
    {
      'name': 'Bakery & Snacks',
      'color': const Color(0xFFF5E5F5),
      'img': AppAssets.icBakerySnacks,
    },
    {
      'name': 'Dairy & Eggs',
      'color': const Color(0xFFF5F0E5),
      'img': AppAssets.icDairyEggs,
    },
    {
      'name': 'Beverage',
      'color': const Color(0xFFE5E5F5),
      'img': AppAssets.icBeverages,
    },
  ];

  String mapCategoryNameToType(String name) {
    switch (name) {
      case 'Frash Fruits & Vegetable':
        return 'Frash Fruits & Vegetable';
      case 'Cooking Oil & Ghee':
        return 'Cooking Oil & Ghee';
      case 'Meat & Fish':
        return 'Meat & Fish';
      case 'Bakery & Snacks':
        return 'Bakery & Snacks';
      case 'Dairy & Eggs':
        return 'Dairy & Eggs';
      case 'Beverage':
        return 'Beverages';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,

            children: [
              SizedBox(height: 50.h),
              Center(
                child: Text(
                  'Find Products',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
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
                onSubmitted: (value) {
                  searchProduct(value);
                },
              ),

              SizedBox(height: 20.h),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15.w,
                  mainAxisSpacing: 15.h,
                  childAspectRatio: 1,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      // showLoadingDialog(context);

                      String categoryName = categories[index]['name'] ?? '';
                      if (categoryName.isEmpty) {
                        // dismissDialog(context);
                        showErrorDialog(context, 'Category name not found');
                        return;
                      }
                      String type = mapCategoryNameToType(categoryName);
                      if (type.isEmpty) {
                        // dismissDialog(context);
                        showErrorDialog(
                          context,
                          'Invalid category name: $categoryName',
                        );
                        return;
                      }

                      print('Fetching products for type: $type');
                      List<Product> product = await exploreController
                          .fetchProductsByType(type);
                      print('Fetched products count: ${product.length}');

                      if (product.isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => CategoryScreen(
                                  title: categories[index]['name'],
                                  product: product,
                                ),
                          ),
                        );
                      } else {
                        showErrorDialog(
                          context,
                          'No products found for ${categories[index]['name']}',
                        );
                      }
                    },

                    child: Container(
                      decoration: BoxDecoration(
                        color: categories[index]['color'],
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            categories[index]['img'],
                            width: 50.w,
                            height: 50.h,
                            fit: BoxFit.fill,
                          ),

                          Text(
                            categories[index]['name'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColor.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void searchProduct(String keyword) async {
    if (keyword.isEmpty) {
      showErrorDialog(context, 'Please enter a search keyword');
      return;
    }
    showLoadingDialog(context);

    List<Product> product = await exploreController.searchProduct(keyword);
    dismissDialog(context);

    if (product.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) => CategoryScreen(title: '$keyword', product: product),
        ),
      );
    } else {
      showErrorDialog(context, 'No product found for "$keyword"');
    }
  }
}
