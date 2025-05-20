import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:online_groceries_app/app_color.dart';
import 'package:online_groceries_app/app_routes_name.dart';
import 'package:online_groceries_app/controller/cart_controller.dart';
import 'package:online_groceries_app/controller/category_controller.dart';

import 'package:online_groceries_app/model/product.dart';
import 'package:online_groceries_app/ui/product_detail_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_groceries_app/model/cart.dart';

class CategoryScreen extends GetView<CategoryController> {
  //final String title;
  //final List<Product> product;

  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(controller.title.value)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.6,
              crossAxisSpacing: 10.w,
              mainAxisSpacing: 10.h,
            ),
            itemCount: controller.productList.length,
            itemBuilder: (context, index) {
              final product = controller.productList[index];
              return GestureDetector(
                onTap: () {
                  Get.to(AppRoutesName.productDetail, arguments: product);
                  //  Get.to(() => ProductDetailScreen(product: product));
                },
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.grey, width: 1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Image.network(
                            product.image,
                            height: 90,
                            width: 90,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(Icons.error, size: 50);
                            },
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          product.title,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4),
                        Text(
                          product.unitPrice,
                          style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\$${product.price.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10),
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
              );
            },
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
}
