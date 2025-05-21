import 'package:get/get.dart';
import 'package:online_groceries_app/controller/category_controller.dart';

class CategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CategoryController());
  }
}
