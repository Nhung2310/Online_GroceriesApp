import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:online_groceries_app/model/product.dart';

class CategoryController extends GetxController {
  //final List<Product> product;
  //final String title;
  //final CartController cartController = Get.put(CartController());
  final productList = <Product>[].obs;
  final RxString title = ''.obs;

  CategoryController({String? title, List<Product>? product}) {
    if (title != null) {
      this.title.value = title;
    }
    if (product != null) {
      productList.addAll(product);
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
