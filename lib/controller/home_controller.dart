import 'package:get/get.dart';
import 'package:online_groceries_app/ui/account_screen.dart';
import 'package:online_groceries_app/ui/cart_screen.dart';
import 'package:online_groceries_app/ui/explore_screen.dart';
import 'package:online_groceries_app/ui/favourite_screen.dart';
import 'package:online_groceries_app/ui/shop_screen.dart';

class HomeController extends GetxController {
  final selectedIndex = 0.obs;

  final screens = [
    const ShopScreen(),
    const ExploreScreen(),
    CartScreen(),
    const FavouriteScreen(),
    const AccountScreen(),
  ];

  void setSelectedIndex(int index) {
    selectedIndex.value = index;
  }
}
