import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_groceries_app/app_assets.dart';
import 'package:online_groceries_app/model/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ExploreController extends GetxController {
  TextEditingController searchController = TextEditingController();
  final isLoading = false.obs;

  final List<Map<String, dynamic>> categories = [
    {
      'name': 'Frash Fruits & Vegetable'.tr,
      'color': const Color(0xFFE5F5E7),
      'img': AppAssets.icFrashFruitsVagetable,
    },
    {
      'name': 'Cooking Oil & Ghee'.tr,
      'color': const Color(0xFFFFF3E5),
      'img': AppAssets.icCookingOilGhee,
    },
    {
      'name': 'Meat & Fish'.tr,
      'color': const Color(0xFFFEE5E5),
      'img': AppAssets.icMeatFish,
    },
    {
      'name': 'Bakery & Snacks'.tr,
      'color': const Color(0xFFF5E5F5),
      'img': AppAssets.icBakerySnacks,
    },
    {
      'name': 'Dairy & Eggs'.tr,
      'color': const Color(0xFFF5F0E5),
      'img': AppAssets.icDairyEggs,
    },
    {
      'name': 'Beverage'.tr,
      'color': const Color(0xFFE5E5F5),
      'img': AppAssets.icBeverages,
    },
  ];

  String mapCategoryNameToType(String name) {
    switch (name) {
      case 'Frash Fruits & Vegetable':
        return 'Fruits & Vegetable';
      case 'Cooking Oil & Ghee':
        return 'Cooking Oil & Ghee';
      case 'Meat & Fish':
        return 'Meat & Fish';
      case 'Bakery & Snacks':
        return 'Bakery & Snacks';
      case 'Dairy & Eggs':
        return 'Dairy & Eggs';
      case 'Beverage':
        return 'Beverages';
      default:
        return '';
    }
  }

  // Future<List<Product>> searchProduct(String keyword) async {
  //   try {
  //     final QuerySnapshot result =
  //         await FirebaseFirestore.instance.collection('products').get();

  //     List<Product> products =
  //         result.docs.map((doc) {
  //           final rawData = doc.data();
  //           if (rawData is Map<String, dynamic>) {
  //             final data = {...rawData, 'id': doc.id};
  //             return Product.fromMap(data);
  //           } else {
  //             throw Exception("Invalid product data format");
  //           }
  //         }).toList();

  //     keyword = keyword.toLowerCase();

  //     return products.where((product) {
  //       final title = product.title.toLowerCase();
  //       final type = (product.type ?? '').toLowerCase();
  //       return title.contains(keyword) || type.contains(keyword);
  //     }).toList();
  //   } catch (e) {
  //     print('Error fetching product: $e');
  //     return [];
  //   }
  // }
}
