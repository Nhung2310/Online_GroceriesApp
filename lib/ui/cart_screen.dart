import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:online_groceries_app/app_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_groceries_app/controller/cart_controller.dart';
import 'package:online_groceries_app/model/cart.dart';
import 'package:online_groceries_app/ui/checkout_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Padding(
        padding: EdgeInsets.fromLTRB(10, 50, 10, 30),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'My Cart',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColor.black,
                ),
              ),

              Obx(() {
                final cartItems = cartController.cartItems();
                cartController.refreshCart();

                if (cartItems.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: const Center(child: Text('Your cart is empty')),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: cartItems.length,

                  itemBuilder: (context, index) {
                    Cart item = cartItems[index];
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          item.title,
                                          style: TextStyle(fontSize: 16.sp),
                                        ),

                                        Align(
                                          alignment: Alignment.topRight,
                                          child: IconButton(
                                            icon: const Icon(Icons.close),
                                            onPressed: () async {
                                              await cartController
                                                  .removeFromCart(
                                                    item.productId,
                                                  );

                                              await cartController
                                                  .refreshCart();
                                            },
                                          ),
                                        ),
                                      ],
                                    ),

                                    Text(
                                      item.unitPrice,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: AppColor.gray,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            IconButton(
                                              onPressed: () async {
                                                if (item.quantity > 1) {
                                                  await cartController
                                                      .updateQuantity(
                                                        item.productId,
                                                        item.quantity - 1,
                                                      );
                                                  await cartController
                                                      .refreshCart();
                                                }
                                              },
                                              icon: const Icon(Icons.remove),
                                            ),
                                            Container(
                                              width: 50.w,
                                              padding: EdgeInsets.symmetric(
                                                vertical: 10.h,
                                              ),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: AppColor.graysearch,
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(20.r),
                                                shape: BoxShape.rectangle,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  '${item.quantity}',
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () async {
                                                await cartController
                                                    .updateQuantity(
                                                      item.productId,
                                                      item.quantity + 1,
                                                    );
                                                await cartController
                                                    .refreshCart();
                                              },
                                              icon: Icon(
                                                Icons.add,
                                                color: AppColor.green,
                                              ),
                                            ),
                                            SizedBox(width: 30.w),
                                            Text(
                                              '\$${item.price}',
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              }),

              SizedBox(height: 20.h),
              Divider(),
              SizedBox(height: 50.h),

              Obx(() {
                double total = cartController.cartItems.fold(
                  0,
                  (sum, item) => sum + item.price * item.quantity,
                );

                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.green,
                    minimumSize: Size(double.infinity, 50.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  onPressed: () {
                    if (cartController.cartItems.isEmpty) {
                      Get.snackbar(
                        'Cart is empty',
                        'There are no items in the cart to order',
                      );
                      return;
                    }
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) => CheckoutScreen(price: total),
                    );
                  },

                  child: Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(
                            'Go to Checkout',
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
                        child: Text(
                          '\$${total.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColor.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
