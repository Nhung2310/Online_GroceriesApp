import 'package:get/get.dart';
import 'package:online_groceries_app/controller/onbording_controller.dart';

class OnbordingBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(OnbordingController());
  }
}
