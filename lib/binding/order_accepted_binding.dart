import 'package:get/get.dart';
import 'package:online_groceries_app/controller/order_acceptec_controller.dart';

class OrderAcceptedBinding extends Bindings {
  @override
  void dependencies() {
    // Lazy load the OrderAcceptedController when it's needed
    Get.lazyPut(() => OrderAcceptecController());
  }
}
