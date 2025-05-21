import 'package:get/get.dart';
import 'package:online_groceries_app/controller/cart_controller.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CartController());
  }
}
