import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:online_groceries_app/model/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductController extends GetxController {
  var exclusiveOfferProducts =
      <Product>[].obs; // Danh sách cho isExclusiveOffer
  var bestSellingProducts = <Product>[].obs; // Danh sách cho isBestSelling
  var groceriesProducts = <Product>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchProductsIsExclusiveOffer();
    fetchProductsIsBestSelling();
    fetchProductsIsGroceries();
  }

  // lấy danh sách từ firestore
  Future<void> fetchProductsIsExclusiveOffer() async {
    try {
      final QuerySnapshot result =
          await FirebaseFirestore.instance
              .collection('products')
              .where('isExclusiveOffer', isEqualTo: true)
              .get();

      var productList =
          result.docs.map((doc) {
            var data = doc.data() as Map<String, dynamic>;
            data['id'] = doc.id; // Thêm id từ Firestore
            return Product.fromMap(data);
          }).toList();

      exclusiveOfferProducts.assignAll(
        productList,
      ); // Cập nhật danh sách sản phẩm
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  Future<void> fetchProductsIsBestSelling() async {
    try {
      final QuerySnapshot result =
          await FirebaseFirestore.instance
              .collection('products')
              .where('isBestSelling', isEqualTo: true)
              .get();

      var productList =
          result.docs.map((doc) {
            var data = doc.data() as Map<String, dynamic>;
            data['id'] = doc.id; // Thêm id từ Firestore
            return Product.fromMap(data);
          }).toList();

      bestSellingProducts.assignAll(productList); // Cập nhật danh sách sản phẩm
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  Future<void> fetchProductsIsGroceries() async {
    try {
      final QuerySnapshot result =
          await FirebaseFirestore.instance
              .collection('products')
              .where('isGroceries', isEqualTo: true)
              .get();

      var productList =
          result.docs.map((doc) {
            var data = doc.data() as Map<String, dynamic>;
            data['id'] = doc.id; // Thêm id từ Firestore
            return Product.fromMap(data);
          }).toList();

      groceriesProducts.assignAll(productList); // Cập nhật danh sách sản phẩm
    } catch (e) {
      print('Error fetching products: $e');
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

  Future<List<Product>> searchProduct(String keyword) async {
    try {
      // Lấy toàn bộ sản phẩm từ Firestore
      final QuerySnapshot result =
          await FirebaseFirestore.instance.collection('products').get();

      List<Product> products =
          result.docs.map((doc) {
            var data = doc.data() as Map<String, dynamic>;
            data['id'] = doc.id;
            return Product.fromMap(data);
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
}
