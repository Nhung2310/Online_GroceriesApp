import 'package:get/get.dart';
import 'package:online_groceries_app/controller/explore_controller.dart';

class ExploreBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ExploreController());
  }
}
