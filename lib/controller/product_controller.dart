import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_groceries_app/model/product.dart';

class ProductController extends GetxController {
  var exclusiveOfferProducts = <Product>[].obs;
  var bestSellingProducts = <Product>[].obs;
  var groceriesProducts = <Product>[].obs;
  var allProducts = <Product>[].obs;
  var productsBySearch = <Product>[].obs;

  final Rx<Product?> product = Rx<Product?>(null);
  final RxInt quantity = 1.obs;
  final RxBool isExpanded = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Khởi tạo danh sách sản phẩm
    fetchProductsIsExclusiveOffer();
    fetchProductsIsBestSelling();
    fetchProductsIsGroceries();
    fetchProductsAll();
  }

  void initializeProductDetail(dynamic arguments) {
    product.value = null;
    quantity.value = 1;
    isExpanded.value = false;

    if (arguments is Product) {
      product.value = arguments;
      print('Product detail loaded: ${product.value?.title}');
    } else {
      print('Error: Get.arguments is not a Product, received: $arguments');
    }
  }

  double get totalPrice =>
      product.value != null ? product.value!.price * quantity.value : 0.0;

  void incrementQuantity() {
    quantity.value++;
  }

  void decrementQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }

  void toggleExpanded() {
    isExpanded.value = !isExpanded.value;
  }

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
            data['id'] = doc.id;
            return Product.fromMap(data);
          }).toList();

      exclusiveOfferProducts.assignAll(productList);
    } catch (e) {
      print('Error fetching exclusive offer products: $e');
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
            data['id'] = doc.id;
            return Product.fromMap(data);
          }).toList();

      bestSellingProducts.assignAll(productList);
    } catch (e) {
      print('Error fetching best selling products: $e');
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
            data['id'] = doc.id;
            return Product.fromMap(data);
          }).toList();

      groceriesProducts.assignAll(productList);
    } catch (e) {
      print('Error fetching groceries products: $e');
    }
  }

  Future<void> fetchProductsAll() async {
    try {
      final QuerySnapshot result =
          await FirebaseFirestore.instance.collection('products').get();
      var productList =
          result.docs.map((doc) {
            var data = doc.data() as Map<String, dynamic>;
            data['id'] = doc.id;
            return Product.fromMap(data);
          }).toList();
      allProducts.assignAll(productList);
    } catch (e) {
      print('Error fetching all products: $e');
    }
  }

  Product? getProductById(String id) {
    return allProducts.firstWhereOrNull((product) => product.id == id);
  }

  Future<List<Product>> fetchSearchProduct(String keyword) async {
    try {
      if (keyword.trim().isEmpty) {
        return [];
      }

      final QuerySnapshot result =
          await FirebaseFirestore.instance
              .collection('products')
              .where('title', isGreaterThanOrEqualTo: keyword.toLowerCase())
              .where(
                'title',
                isLessThanOrEqualTo: '${keyword.toLowerCase()}\uf8ff',
              )
              .get();

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
      final productList =
          products.where((product) {
            final title = (product.title).toLowerCase();
            final type = (product.type ?? '').toLowerCase();
            return title.contains(keyword) || type.contains(keyword);
          }).toList();

      productsBySearch.assignAll(productList);
      print('Fetched search products: ${productList.length}');
      return productList;
    } catch (e) {
      print('Error fetching search product: $e');
      return [];
    }
  }

  Future<List<Product>> fetchProductsByType(String type) async {
    try {
      if (type.trim().isEmpty) {
        print('Error: Type is empty');
        return [];
      }

      print('Querying Firestore for type: $type');
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

      print('Fetched ${productList.length} products for type: $type');
      return productList;
    } catch (e) {
      print('Error fetching products by type: $e');
      return [];
    }
  }
}
