import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_groceries_app/app_color.dart';
import 'package:online_groceries_app/controller/cart_controller.dart';

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

                TitleGray('Checkout'),
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
                TitleGray('Delivery'),

                Spacer(),
                TitleBold('Select Method'),

                IconButtonForward(),
              ],
            ),
            Divider(),
            Row(
              children: [
                SizedBox(width: 10.w),
                TitleGray('Payment'),

                Spacer(),
                Icon(Icons.payment, color: AppColor.green),
                IconButtonForward(),
              ],
            ),
            Divider(),
            Row(
              children: [
                SizedBox(width: 10.w),
                TitleGray('Promo Code'),

                Spacer(),
                TitleBold('Pich discount'),
                IconButtonForward(),
              ],
            ),
            Divider(),
            Row(
              children: [
                SizedBox(width: 10.w),
                TitleGray('Total Cost'),

                Spacer(),
                Text(
                  '\$${price.toStringAsFixed(2)}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButtonForward(),
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
                    await cartController.clearCart();
                    await cartController.fetchCartItems();
                    // Get.off(() => OrderAccepted());
                    Get.offNamed('/order-accepted');
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

  Widget TitleBold(String title) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
    );
  }

  Widget TitleGray(String title) {
    return Text(title, style: TextStyle(fontSize: 14.sp, color: AppColor.gray));
  }

  Widget IconButtonForward() {
    return IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward_ios));
  }
}
