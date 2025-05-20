import 'package:get/get.dart';
import 'package:online_groceries_app/controller/email_verified_controller.dart';

class EmailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EmailVerifiedController());
  }
}
