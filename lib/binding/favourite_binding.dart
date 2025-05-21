import 'package:get/get.dart';
import 'package:online_groceries_app/controller/favorites_controller.dart';
import 'package:online_groceries_app/ui/favourite_screen.dart';

class FavouriteBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FavoritesController());
  }
}
