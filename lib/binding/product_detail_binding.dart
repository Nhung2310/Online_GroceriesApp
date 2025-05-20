import 'package:get/get.dart';

class ProductDetailBinding extends Bindings {
  @override
  void dependencies() {
    // Lazy load the ProductDetailController when it's needed
    Get.lazyPut(() => ProductDetailBinding());
  }
}
