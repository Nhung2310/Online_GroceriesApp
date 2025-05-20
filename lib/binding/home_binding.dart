import 'package:get/get.dart';
import 'package:online_groceries_app/controller/home_controller.dart';
import 'package:online_groceries_app/controller/shop_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(() => ShopController());
    // Lazy load the HomeController when it's needed
    Get.lazyPut(() => HomeController());
  }
}
