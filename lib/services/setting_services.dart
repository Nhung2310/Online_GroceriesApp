import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? sharedPreferences;

class SettingServices extends GetxService {
  RxInt count = 0.obs;
  Future<SettingServices> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    count.value = sharedPreferences?.getInt('count') ?? 0;
    return this;
  }

  void increment() {
    count.value++;
    sharedPreferences?.setInt('count', count.value);
  }
}
