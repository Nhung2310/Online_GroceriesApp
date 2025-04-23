import 'package:flutter/material.dart';
import 'package:online_groceries_app/app_color.dart';
import 'package:online_groceries_app/ui/account_screen.dart';
import 'package:online_groceries_app/ui/cart_screen.dart';
import 'package:online_groceries_app/ui/explore_screen.dart';
import 'package:online_groceries_app/ui/favourite_screen.dart';
import 'package:online_groceries_app/ui/shop_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    ShopScreen(),
    ExploreScreen(),
    CartScreen(),
    FavouriteScreen(),
    AccountScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: AppColor.green,
        unselectedItemColor: AppColor.black,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.storefront_sharp),

            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.manage_search_sharp),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_checkout_outlined),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_outlined),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.manage_accounts_outlined),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
