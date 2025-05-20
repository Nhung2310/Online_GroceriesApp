import 'package:get/get.dart';

import 'package:online_groceries_app/services/setting_services.dart';

class RootBinding implements Bindings {
  RootBinding();

  @override
  void dependencies() {
    Get.put(SettingServices(), permanent: true);
  }
}
