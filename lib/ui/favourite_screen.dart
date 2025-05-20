import 'package:flutter/material.dart';
import 'package:online_groceries_app/app_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_groceries_app/app_routes_name.dart';
import 'package:online_groceries_app/controller/cart_controller.dart';
import 'package:online_groceries_app/controller/favorites_controller.dart';
import 'package:online_groceries_app/controller/product_controller.dart';
import 'package:online_groceries_app/model/favorites.dart';
import 'package:online_groceries_app/ui/product_detail_screen.dart';
import 'package:get/get.dart';
import 'package:online_groceries_app/model/cart.dart';

class FavouriteScreen extends GetView<FavoritesController> {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: AppColor.white,
        body: Padding(
          padding: EdgeInsets.fromLTRB(10, 50, 10, 30),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Favourite',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColor.black,
                  ),
                ),

                controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : controller.favoritesList.isEmpty
                    ? const Center(child: Text('Your Favorites is empty'))
                    : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.favoritesList.length,
                      itemBuilder: (context, index) {
                        Favorites item = controller.favoritesList[index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: 10.h),
                          child: Column(
                            children: [
                              Divider(),
                              Row(
                                children: [
                                  Image.network(
                                    item.image,
                                    width: 100.w,
                                    height: 100.w,
                                    fit: BoxFit.contain,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const Icon(Icons.error),
                                  ),
                                  SizedBox(width: 10.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.title,
                                          style: TextStyle(fontSize: 16.sp),
                                        ),

                                        Text(
                                          item.unitPrice,
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: AppColor.gray,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Text(
                                    '\$${item.price}',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  IconButton(
                                    onPressed: () {
                                      final product =
                                          Get.find<ProductController>()
                                              .getProductById(item.productId);
                                      if (product != null) {
                                        Get.toNamed(
                                          AppRoutesName.productDetail,
                                          arguments: product,
                                        );
                                      } else {
                                        Get.snackbar(
                                          'Lỗi',
                                          'Không tìm thấy sản phẩm!',
                                        );
                                      }
                                    },
                                    icon: Icon(Icons.arrow_forward_ios),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                SizedBox(height: 20.h),
                Divider(),
                SizedBox(height: 40.h),
                buildCartItem(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCartItem() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Obx(
        () => ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.green,
            minimumSize: Size(double.infinity, 50.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
          onPressed:
              controller.isLoading.value
                  ? null
                  : () async {
                    if (controller.favoritesList.isEmpty) {
                      Get.snackbar(
                        'Favorites is empty',
                        'There are no items in your wishlist to add to cart',
                      );
                      return;
                    }
                    final cartController = Get.find<CartController>();
                    for (var favorite in controller.favoritesList) {
                      Cart cartItem = Cart(
                        productId: favorite.productId,
                        title: favorite.title,
                        unitPrice: favorite.unitPrice,
                        image: favorite.image,
                        price: favorite.price,
                        quantity: favorite.quantity,
                      );
                      try {
                        await cartController.addToCart(cartItem);
                      } catch (e) {
                        print('Error adding ${cartItem.title} to cart: $e');
                      }
                    }
                    Get.snackbar(
                      'Success',
                      'Successfully added all items to cart!',
                    );
                  },
          child: Text(
            'Add All To Cart',
            style: TextStyle(fontSize: 16.sp, color: AppColor.white),
          ),
        ),
      ),
    );
  }
}
