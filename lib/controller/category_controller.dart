import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:online_groceries_app/model/product.dart';

class CategoryController extends GetxController {
  //final List<Product> product;
  //final String title;
  //final CartController cartController = Get.put(CartController());
  final productList = <Product>[].obs;
  final RxString title = ''.obs;

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments as Map<String, dynamic>?;
    if (arguments != null) {
      final products = arguments['products'] as List<Product>?;
      final titleArg = arguments['title'] as String?;
      if (products != null) {
        productList.assignAll(products);
      }
      if (titleArg != null) {
        title.value = titleArg;
      }
    }
  }

  // CategoryController({String? title, List<Product>? product}) {
  //   if (title != null) {
  //     this.title.value = title;
  //   }
  //   if (product != null) {
  //     productList.addAll(product);
  //   }
  // }

  @override
  void onClose() {
    super.onClose();
  }
}
