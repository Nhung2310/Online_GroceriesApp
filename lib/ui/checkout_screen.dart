import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_groceries_app/app_color.dart';
import 'package:online_groceries_app/controller/cart_controller.dart';
import 'package:online_groceries_app/model/cart.dart';
import 'package:online_groceries_app/ui/order_accepted.dart';
import 'package:online_groceries_app/ui/shop_screen.dart';
import 'package:get/get.dart';

class CheckoutScreen extends StatelessWidget {
  final double price;

  const CheckoutScreen({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();
    return FractionallySizedBox(
      heightFactor: 0.6,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(width: 10.w),
                Text(
                  'Checkout',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close),
                ),
              ],
            ),
            Divider(),
            Row(
              children: [
                SizedBox(width: 10.w),
                Text(
                  'Delivery',
                  style: TextStyle(fontSize: 14.sp, color: AppColor.gray),
                ),
                Spacer(),

                Text(
                  'Select Method',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
            Divider(),
            Row(
              children: [
                SizedBox(width: 10.w),
                Text(
                  'Payment',
                  style: TextStyle(fontSize: 14.sp, color: AppColor.gray),
                ),
                Spacer(),
                Icon(Icons.payment, color: AppColor.green),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
            Divider(),
            Row(
              children: [
                SizedBox(width: 10.w),
                Text(
                  'Promo Code',
                  style: TextStyle(fontSize: 14.sp, color: AppColor.gray),
                ),
                Spacer(),

                Text(
                  'Pich discount',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
            Divider(),
            Row(
              children: [
                SizedBox(width: 10.w),
                Text(
                  'Total Cost',
                  style: TextStyle(fontSize: 14.sp, color: AppColor.gray),
                ),
                Spacer(),
                Text(
                  '\$${price.toStringAsFixed(2)}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),

            Divider(),
            SizedBox(height: 10.h),
            RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 16.sp),
                children: [
                  TextSpan(
                    text: 'By placing an order you agree to our',
                    style: TextStyle(color: AppColor.gray),
                  ),
                  TextSpan(
                    text: ' Terms',
                    style: TextStyle(
                      color: AppColor.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: ' And',
                    style: TextStyle(color: AppColor.gray),
                  ),
                  TextSpan(
                    text: ' Conditions',
                    style: TextStyle(
                      color: AppColor.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),

            SizedBox(
              width: 300.w,
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    // if (cartController.cartItems.isEmpty) {
                    //   Get.snackbar(
                    //     'Cart is empty',
                    //     'There are no items in the cart to order',
                    //   );
                    //   return;
                    // }
                    await cartController.clearCart();
                    await cartController.fetchCartItems();
                    Get.off(() => OrderAccepted());
                  } catch (e) {
                    Get.snackbar('Error', 'Cannot place order: $e');
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15.h),
                  backgroundColor: AppColor.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'Place Order',
                  style: TextStyle(fontSize: 14.sp, color: AppColor.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
