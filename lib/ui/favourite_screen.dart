import 'package:flutter/material.dart';
import 'package:online_groceries_app/app_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_groceries_app/controller/cart_controller.dart';
import 'package:online_groceries_app/controller/favorites_controller.dart';
import 'package:online_groceries_app/controller/product_controller.dart';
import 'package:online_groceries_app/model/favorites.dart';
import 'package:online_groceries_app/ui/product_detail_screen.dart';
import 'package:get/get.dart';
import 'package:online_groceries_app/model/cart.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  final FavoritesController favoritesController = FavoritesController();
  final ProductController controller = Get.find();
  final CartController cartController = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Padding(
        padding: EdgeInsets.fromLTRB(10, 50, 10, 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Favorurite',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColor.black,
                ),
              ),

              FutureBuilder<List<Favorites>>(
                future: favoritesController.getFavoritesItems(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError || snapshot.data == null) {
                    return const Center(child: Text('Error loading Favorites'));
                  }
                  List<Favorites> cartItems = snapshot.data!;
                  if (cartItems.isEmpty) {
                    return Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: const Center(
                        child: Text('Your Favorites is empty'),
                      ),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      Favorites item = cartItems[index];
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
                                    final product = controller.getProductById(
                                      item.productId,
                                    );
                                    if (product != null) {
                                      Get.to(
                                        () => ProductDetailScreen(
                                          product: product,
                                        ),
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
                  );
                },
              ),
              SizedBox(height: 20.h),
              Divider(),
              SizedBox(height: 40.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: FutureBuilder<List<Favorites>>(
                  future: favoritesController.getFavoritesItems(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting ||
                        snapshot.hasError ||
                        snapshot.data == null) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.green,
                          minimumSize: Size(double.infinity, 50.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text(
                          'Add All To Cart',
                          style: TextStyle(fontSize: 16, color: AppColor.white),
                        ),
                      );
                    }
                    List<Favorites> favoritesItems = snapshot.data!;

                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.green,
                        minimumSize: Size(double.infinity, 50.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      onPressed: () async {
                        if (favoritesItems.isEmpty) {
                          Get.snackbar(
                            'Favorites is empty',
                            'There are no items in your wishlist to add to cart',
                          );
                          return;
                        }
                        for (var favorite in favoritesItems) {
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
                      child: Row(
                        children: [
                          Expanded(
                            child: Center(
                              child: Text(
                                'Add All To Cart',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: AppColor.white,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 5.h,
                            ),
                            color: AppColor.green,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
