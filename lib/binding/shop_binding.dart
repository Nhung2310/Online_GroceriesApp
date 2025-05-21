import 'package:get/get.dart';
import 'package:online_groceries_app/controller/shop_controller.dart';

class ShopBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ShopController());
  }
}
