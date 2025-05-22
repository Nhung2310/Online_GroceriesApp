import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_groceries_app/app_color.dart';
import 'package:online_groceries_app/app_routes_name.dart';
import 'package:online_groceries_app/controller/cart_controller.dart';

import 'package:get/get.dart';
import 'package:online_groceries_app/controller/checkout_controller.dart';

class CheckoutScreen extends GetView<CheckoutController> {
  final double price;

  const CheckoutScreen({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    //final CartController cartController = Get.find<CartController>();
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

                TitleGray('Checkout'.tr),
                Spacer(),
                IconButton(
                  onPressed: () {
                    // Navigator.pop(context);
                    Get.back();
                  },
                  icon: Icon(Icons.close),
                ),
              ],
            ),
            Divider(),
            Row(
              children: [
                SizedBox(width: 10.w),
                TitleGray('Delivery'.tr),

                Spacer(),
                TitleBold('Select Method'.tr),

                IconButtonForward(),
              ],
            ),
            Divider(),
            Row(
              children: [
                SizedBox(width: 10.w),
                TitleGray('Payment'.tr),

                Spacer(),
                Icon(Icons.payment, color: AppColor.green),
                IconButtonForward(),
              ],
            ),
            Divider(),
            Row(
              children: [
                SizedBox(width: 10.w),
                TitleGray('Promo Code'.tr),

                Spacer(),
                TitleBold('Pich discount'.tr),
                IconButtonForward(),
              ],
            ),
            Divider(),
            Row(
              children: [
                SizedBox(width: 10.w),
                TitleGray('Total Cost'.tr),

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
                    text: 'By placing an order you agree to our'.tr,
                    style: TextStyle(color: AppColor.gray),
                  ),
                  TextSpan(
                    text: ' Terms'.tr,
                    style: TextStyle(
                      color: AppColor.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: ' And'.tr,
                    style: TextStyle(color: AppColor.gray),
                  ),
                  TextSpan(
                    text: ' Conditions'.tr,
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
                    await Get.find<CartController>().clearCart();

                    await Get.find<CartController>().fetchCartItems();

                    Get.offNamed(AppRoutesName.orderAccepted);
                  } catch (e) {
                    Get.snackbar('Error'.tr, 'Cannot place order: $e'.tr);
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
                  'Place Order'.tr,
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
