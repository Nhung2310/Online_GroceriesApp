import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:online_groceries_app/model/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ExploreController extends GetxController {
  Future<List<Product>> searchProduct(String keyword) async {
    try {
      final QuerySnapshot result =
          await FirebaseFirestore.instance.collection('products').get();

      List<Product> products =
          result.docs.map((doc) {
            final rawData = doc.data();
            if (rawData is Map<String, dynamic>) {
              final data = {...rawData, 'id': doc.id};
              return Product.fromMap(data);
            } else {
              throw Exception("Invalid product data format");
            }
          }).toList();

      keyword = keyword.toLowerCase();

      return products.where((product) {
        final title = product.title.toLowerCase();
        final type = (product.type ?? '').toLowerCase();
        return title.contains(keyword) || type.contains(keyword);
      }).toList();
    } catch (e) {
      print('Error fetching product: $e');
      return [];
    }
  }

  Future<List<Product>> fetchProductsByType(String type) async {
    try {
      final QuerySnapshot result =
          await FirebaseFirestore.instance
              .collection('products')
              .where('type', isEqualTo: type)
              .get();
      var productList =
          result.docs.map((doc) {
            var data = doc.data() as Map<String, dynamic>;
            data['id'] = doc.id;
            return Product.fromMap(data);
          }).toList();
      return productList;
    } catch (e) {
      print('Error fetching product:$e');
      return [];
    }
  }
}
