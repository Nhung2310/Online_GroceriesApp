import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_groceries_app/app_assets.dart';
import 'package:online_groceries_app/app_color.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:online_groceries_app/controller/cart_controller.dart';
import 'package:online_groceries_app/controller/product_controller.dart';
import 'package:online_groceries_app/model/product.dart';
import 'package:online_groceries_app/ui/beverages_screen.dart';
import 'package:online_groceries_app/ui/product_detail_screen.dart';
import 'package:online_groceries_app/model/cart.dart';
import 'package:online_groceries_app/widget/error_dialog.dart';
import 'package:online_groceries_app/widget/loading_dialog.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});
  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final ProductController productController = Get.put(ProductController());

  TextEditingController searchController = TextEditingController();

  final CartController cartController = CartController();
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
                onSubmitted: (value) {
                  searchProduct(value);
                },
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
              text('Exclusive Offer', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => BeveragesScreen(
                          title: 'Exclusive Offer',
                          product: productController.exclusiveOfferProducts,
                        ),
                  ),
                );
              }),

              Obx(() {
                if (productController.exclusiveOfferProducts.isEmpty) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return SizedBox(
                    height: 250.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      physics: AlwaysScrollableScrollPhysics(),

                      itemCount:
                          productController.exclusiveOfferProducts.length > 3
                              ? 3
                              : productController.exclusiveOfferProducts.length,

                      itemBuilder: (context, index) {
                        final product =
                            productController.exclusiveOfferProducts[index];
                        return GestureDetector(
                          onTap: () {
                            // Điều hướng sang màn hình chi tiết sản phẩm
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) =>
                                        ProductDetailScreen(product: product),
                              ),
                            );
                          },

                          child: Card(
                            elevation: 0,

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              side: BorderSide(color: AppColor.gray, width: 1),
                            ),
                            child: Container(
                              width: 180.w,
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
                                        errorBuilder: (
                                          context,
                                          error,
                                          stackTrace,
                                        ) {
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
                                            borderRadius: BorderRadius.circular(
                                              10.r,
                                            ),
                                          ),
                                          child: buildAddToCartButton(
                                            product,
                                            cartController,
                                            context,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              }),
              SizedBox(height: 30.h),

              text('Best Selling', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => BeveragesScreen(
                          title: 'Best Selling',
                          product: productController.bestSellingProducts,
                        ),
                  ),
                );
              }),

              Obx(() {
                if (productController.bestSellingProducts.isEmpty) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return SizedBox(
                    height: 250.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      physics: AlwaysScrollableScrollPhysics(),

                      itemCount:
                          productController.bestSellingProducts.length > 3
                              ? 3
                              : productController.bestSellingProducts.length,
                      //itemCount: productController.bestSellingProducts.length,
                      itemBuilder: (context, index) {
                        final product =
                            productController.bestSellingProducts[index];
                        return GestureDetector(
                          onTap: () {
                            // Điều hướng sang màn hình chi tiết sản phẩm
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) =>
                                        ProductDetailScreen(product: product),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              side: BorderSide(color: AppColor.gray, width: 1),
                            ),
                            child: Container(
                              width: 180.w,
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
                                        errorBuilder: (
                                          context,
                                          error,
                                          stackTrace,
                                        ) {
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
                                            borderRadius: BorderRadius.circular(
                                              10.r,
                                            ),
                                          ),
                                          child: buildAddToCartButton(
                                            product,
                                            cartController,
                                            context,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              }),
              SizedBox(height: 30.h),

              text('Groceries', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => BeveragesScreen(
                          title: 'Groceries',
                          product: productController.groceriesProducts,
                        ),
                  ),
                );
              }),
              Obx(() {
                if (productController.groceriesProducts.isEmpty) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return SizedBox(
                    height: 250.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      physics: AlwaysScrollableScrollPhysics(),

                      itemCount:
                          productController.groceriesProducts.length > 3
                              ? 3
                              : productController.groceriesProducts.length,
                      itemBuilder: (context, index) {
                        final product =
                            productController.groceriesProducts[index];
                        return GestureDetector(
                          onTap: () {
                            // Điều hướng sang màn hình chi tiết sản phẩm
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) =>
                                        ProductDetailScreen(product: product),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              side: BorderSide(color: AppColor.gray, width: 1),
                            ),
                            child: Container(
                              width: 180.w,
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
                                        errorBuilder: (
                                          context,
                                          error,
                                          stackTrace,
                                        ) {
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
                                            borderRadius: BorderRadius.circular(
                                              10.r,
                                            ),
                                          ),
                                          child: buildAddToCartButton(
                                            product,
                                            cartController,
                                            context,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
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

  Widget text(String text, VoidCallback onSeeAllTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(
            color: AppColor.black,
            fontWeight: FontWeight.bold,
            fontSize: 15.sp,
          ),
        ),

        GestureDetector(
          onTap: onSeeAllTap,
          child: Text(
            'See all',
            style: TextStyle(color: AppColor.green, fontSize: 14.sp),
          ),
        ),
      ],
    );
  }

  Widget buildAddToCartButton(
    Product product,
    CartController cartController,
    BuildContext context,
  ) {
    return IconButton(
      icon: Icon(Icons.add, color: AppColor.white, size: 20.sp),
      onPressed: () async {
        try {
          final cartItem = Cart(
            productId: product.id,
            title: product.title,
            price: product.price,
            quantity: 1,
            unitPrice: product.unitPrice,
            image: product.image,
          );
          await cartController.addToCart(cartItem);
          await cartController.refreshCart();
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Added to cart!')));
        } catch (e) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error: $e')));
        }
      },
    );
  }

  void searchProduct(String keyword) async {
    if (keyword.isEmpty) {
      showErrorDialog(context, 'Please enter a search keyword');
      return;
    }
    showLoadingDialog(context);

    List<Product> product = await productController.searchProduct(keyword);
    dismissDialog(context);

    if (product.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) => BeveragesScreen(
                title: 'Search results for "$keyword"',
                product: product,
              ),
        ),
      );
    } else {
      showErrorDialog(context, 'No product found for "$keyword"');
    }
  }
}
