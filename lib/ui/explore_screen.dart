import 'package:flutter/material.dart';

import 'package:online_groceries_app/app_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_groceries_app/app_routes_name.dart';

import 'package:online_groceries_app/controller/explore_controller.dart';
import 'package:online_groceries_app/controller/product_controller.dart';
import 'package:online_groceries_app/model/product.dart';

import 'package:online_groceries_app/widget/error_dialog.dart';
import 'package:online_groceries_app/widget/loading_dialog.dart';
import 'package:get/get.dart';

class ExploreScreen extends GetView<ExploreController> {
  const ExploreScreen({super.key});

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
                  'Find Products'.tr,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              buildTextField(context),

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
                itemCount: controller.categories.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      String categoryName =
                          controller.categories[index]['name'] ?? '';
                      if (categoryName.isEmpty) {
                        showErrorDialog(context, 'Category name not found'.tr);
                        return;
                      }
                      String type = controller.mapCategoryNameToType(
                        categoryName,
                      );
                      if (type.isEmpty) {
                        showErrorDialog(
                          context,
                          'Invalid category name: $categoryName'.tr,
                        );
                        return;
                      }

                      print('Fetching products for type: $type'.tr);
                      final productController = Get.find<ProductController>();
                      List<Product> product = await productController
                          .fetchProductsByType(type);
                      print('Fetched products count: ${product.length}'.tr);

                      if (product.isNotEmpty) {
                        Get.toNamed(
                          AppRoutesName.category,
                          arguments: {
                            'title': controller.categories[index]['name'],
                            'products': product,
                          },
                        );
                      } else {
                        showErrorDialog(
                          context,
                          'No products found for ${controller.categories[index]['name']}'
                              .tr,
                        );
                      }
                    },

                    child: Container(
                      decoration: BoxDecoration(
                        color: controller.categories[index]['color'],
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            controller.categories[index]['img'],
                            width: 50.w,
                            height: 50.h,
                            fit: BoxFit.fill,
                          ),

                          Text(
                            controller.categories[index]['name'],
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

  void searchProduct(BuildContext context, String keyword) async {
    if (keyword.isEmpty) {
      showErrorDialog(context, 'Please enter a search keyword'.tr);
      return;
    }
    showLoadingDialog(context);
    final productController = Get.find<ProductController>();
    List<Product> product = await productController.fetchSearchProduct(keyword);
    dismissDialog(context);

    if (product.isNotEmpty) {
      Get.toNamed(
        AppRoutesName.category,
        arguments: {'products': product, 'title': '$keyword'},
      );
    } else {
      showErrorDialog(context, 'No product found for "$keyword"'.tr);
    }
  }

  Widget buildTextField(BuildContext context) {
    return TextField(
      controller: controller.searchController,
      decoration: InputDecoration(
        hintText: 'Search Store'.tr,
        hintStyle: TextStyle(color: AppColor.gray, fontSize: 14.sp),
        prefixIcon: Icon(Icons.search, color: AppColor.black, size: 20.sp),
        contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
        filled: true,
        fillColor: AppColor.graysearch,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide(color: AppColor.graysearch, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide(color: AppColor.graysearch, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide(color: AppColor.graysearch, width: 1),
        ),
      ),
      style: TextStyle(fontSize: 14.sp, color: AppColor.black),
      onSubmitted: (value) {
        searchProduct(context, value);
      },
    );
  }
}
