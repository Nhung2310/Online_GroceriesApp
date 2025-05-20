import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_groceries_app/app_color.dart';
import 'package:online_groceries_app/controller/cart_controller.dart';
import 'package:online_groceries_app/controller/favorites_controller.dart';
import 'package:online_groceries_app/controller/product_detail_controller.dart';
import 'package:online_groceries_app/model/cart.dart';

import 'package:online_groceries_app/model/product.dart';
import 'package:online_groceries_app/widget/favorite_button.dart';
import 'package:get/get.dart';

class ProductDetailScreen extends GetView<ProductDetailController> {
  //final Product product;

  int tam = 1;
  bool _isExpanded = false;
  final CartController cartController = CartController();
  final FavoritesController favoritesController = FavoritesController();
  @override
  Widget build(BuildContext context) {
    final product = controller.product;

    return Scaffold(
      extendBodyBehindAppBar: false,

      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(300),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(24),
            bottomRight: Radius.circular(24),
          ),
          child: Container(
            color: AppColor.graysearch,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Image.network(
                      product.image,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(color: Colors.grey[200]);
                      },
                    ),
                  ),
                ),

                Positioned(
                  top: MediaQuery.of(context).padding.top + 10,
                  left: 10,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: AppColor.black),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),

                Positioned(
                  top: MediaQuery.of(context).padding.top + 10,
                  right: 10,
                  child: IconButton(
                    icon: const Icon(Icons.ios_share, color: AppColor.black),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    product.title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  FavoriteButton(
                    product: product,
                    favoritesController: favoritesController,
                  ),
                ],
              ),

              Text(
                product.unitPrice,
                style: TextStyle(fontSize: 14.sp, color: AppColor.gray),
              ),
              SizedBox(height: 30.h),
              Obx(() => buildPrice()),

              // buildPrice(),
              SizedBox(height: 30.h),
              Divider(),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Product Detail',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () {
                      controller.toggleExpanded();
                    },
                    icon: Icon(
                      _isExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: AppColor.black,
                      size: 40.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Obx(
                () =>
                    controller.isExpanded.value
                        ? Text(
                          product.description,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColor.gray,
                          ),
                        )
                        : Text(
                          product.description,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColor.gray,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
              ),
              SizedBox(height: 30.h),
              Divider(),
              SizedBox(height: 10.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Nutritions',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios, color: AppColor.black),
                ],
              ),
              SizedBox(height: 30.h),
              Divider(),
              SizedBox(height: 10.h),
              buildReview(product),

              SizedBox(height: 30.h),
              buildAddToCartButton(
                product,
                Get.find<CartController>(),
                context,
              ),
            ],
          ),
        ),
      ),
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
          Get.snackbar('Success', 'Successfully added to cart!');
        } catch (e) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error: $e')));
        }
      },
    );
  }

  Widget buildReview(Product product) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Review',
          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            Row(
              children: List.generate(5, (index) {
                return Icon(
                  index < product.review ? Icons.star : Icons.star_border,
                  color:
                      index < product.review
                          ? const Color.fromARGB(255, 231, 110, 53)
                          : const Color.fromARGB(255, 158, 158, 158),
                  size: 30.sp,
                );
              }),
            ),
            SizedBox(width: 10.w),
            Icon(Icons.arrow_forward_ios, color: AppColor.black),
          ],
        ),
      ],
    );
  }

  Widget buildPrice() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () {
                controller.decrementQuantity();
              },
              icon: const Icon(Icons.remove),
            ),
            Container(
              width: 50.w,
              padding: EdgeInsets.symmetric(vertical: 10.h),
              decoration: BoxDecoration(
                border: Border.all(color: AppColor.graysearch, width: 2),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Center(
                child: Text(
                  controller.quantity.value.toString(),
                  style: TextStyle(fontSize: 14.sp),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                controller.incrementQuantity();
              },
              icon: Icon(Icons.add, color: AppColor.green),
            ),
          ],
        ),
        Text(
          '\$${controller.totalPrice}',
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
