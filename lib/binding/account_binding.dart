import 'package:get/get.dart';
import 'package:online_groceries_app/controller/account_controller.dart';

class AccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AccountController());
  }
}
