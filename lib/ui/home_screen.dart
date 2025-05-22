import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/state_manager.dart';
import 'package:online_groceries_app/app_color.dart';
import 'package:online_groceries_app/controller/home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: controller.screens[controller.selectedIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.selectedIndex.value,
          onTap: (index) {
            controller.setSelectedIndex(index); // Cập nhật selectedIndex
          },
          selectedItemColor: AppColor.green,
          unselectedItemColor: AppColor.black,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.storefront_sharp),

              label: 'Shop'.tr,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.manage_search_sharp),
              label: 'Explore'.tr,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_checkout_outlined),
              label: 'Cart'.tr,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border_outlined),
              label: 'Favorite'.tr,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_2_outlined),
              label: 'Account'.tr,
            ),
          ],
        ),
      ),
    );
  }
}
