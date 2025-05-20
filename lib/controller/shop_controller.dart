import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_groceries_app/controller/cart_controller.dart';
import 'package:online_groceries_app/controller/product_controller.dart';

class ShopController extends GetxController {
  final ProductController productController = Get.put(ProductController());
  final CartController cartController = CartController();
  TextEditingController searchController = TextEditingController();

  @override
  void onClose() {
    productController.dispose();
    cartController.dispose();
    searchController.dispose();
    super.onClose();
  }
}
