import 'package:get/get.dart';
import 'package:online_groceries_app/controller/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
  }
}
