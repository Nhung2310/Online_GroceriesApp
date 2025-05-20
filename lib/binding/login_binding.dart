import 'package:get/get.dart';
import 'package:online_groceries_app/controller/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    // Lazy load the LoginController when it's needed
    Get.lazyPut(() => LoginController());
  }
}
