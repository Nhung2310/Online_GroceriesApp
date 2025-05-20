import 'package:get/get.dart';
import 'package:online_groceries_app/model/product.dart';

class ProductDetailController extends GetxController {
  final Product product = Get.arguments;
  final quantity = 1.obs;
  final isExpanded = false.obs;

  double get totalPrice => product.price * quantity.value;

  void incrementQuantity() {
    quantity.value++;
  }

  void decrementQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }

  void toggleExpanded() {
    isExpanded.value = !isExpanded.value;
  }
}
