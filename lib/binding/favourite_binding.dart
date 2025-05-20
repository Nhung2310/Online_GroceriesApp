import 'package:get/get.dart';
import 'package:online_groceries_app/ui/favourite_screen.dart';

class FavouriteBinding extends Bindings {
  @override
  void dependencies() {
    // Lazy load the FavouriteController when it's needed
    Get.lazyPut(() => FavouriteScreen());
  }
}
