import 'package:get/get.dart';
import 'package:online_groceries_app/controller/product_controller.dart';

class ProductDetailBinding extends Bindings {
  @override
  void dependencies() {
    // Lazy load the ProductDetailController when it's needed
    Get.put(ProductController());
  }
}
