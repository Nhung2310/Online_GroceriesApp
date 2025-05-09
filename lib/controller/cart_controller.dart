import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';
import 'package:online_groceries_app/model/cart.dart';

class CartController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

  final RxList<Cart> cartItems = <Cart>[].obs;
  @override
  void onInit() {
    super.onInit();
    fetchCartItems();
  }

  Future<void> fetchCartItems() async {
    try {
      cartItems.value = await getCartItems();
    } catch (e) {
      Get.snackbar('Error', 'Failed to load cart items');
    }
  }

  Future<void> refreshCart() async {
    await fetchCartItems();
  }

  Future<void> addToCart(Cart cartItem) async {
    if (userId.isEmpty) {
      throw Exception('User not logged in');
    }

    try {
      DocumentReference cartItemRef = _firestore
          .collection('user')
          .doc(userId)
          .collection('carts')
          .doc(cartItem.productId);

      DocumentSnapshot cartItemSnapshot = await cartItemRef.get();

      if (cartItemSnapshot.exists) {
        await cartItemRef.update({'quantity': FieldValue.increment(1)});
      } else {
        await cartItemRef.set(cartItem.toMap());
      }
    } catch (e) {
      throw Exception('Error adding to cart: $e');
    }
  }

  Future<List<Cart>> getCartItems() async {
    if (userId.isEmpty) {
      throw Exception('User not logged in');
    }

    try {
      QuerySnapshot cartItemsSnapshot =
          await _firestore
              .collection('user')
              .doc(userId)
              .collection('carts')
              .get();

      return cartItemsSnapshot.docs.map((doc) {
        return Cart.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    } catch (e) {
      throw Exception('Error fetching cart: $e');
    }
  }

  Future<void> updateQuantity(String productId, int newQuantity) async {
    if (userId.isEmpty) {
      throw Exception('User not logged in');
    }

    try {
      DocumentReference cartItemRef = _firestore
          .collection('user')
          .doc(userId)
          .collection('carts')
          .doc(productId);

      if (newQuantity <= 0) {
        await cartItemRef.delete();
      } else {
        await cartItemRef.update({'quantity': newQuantity});
      }
    } catch (e) {
      throw Exception('Error updating cart: $e');
    }
  }

  Future<void> removeFromCart(String productId) async {
    if (userId.isEmpty) {
      throw Exception('User not logged in');
    }

    try {
      await _firestore
          .collection('user')
          .doc(userId)
          .collection('carts')
          .doc(productId)
          .delete();
    } catch (e) {
      throw Exception('Error removing from cart: $e');
    }
  }

  Future<void> clearCart() async {
    if (userId.isEmpty) {
      throw Exception('User not logged in');
    }

    try {
      final cartCollection = _firestore
          .collection('user')
          .doc(userId)
          .collection('carts');

      final snapshot = await cartCollection.get();
      for (var doc in snapshot.docs) {
        await doc.reference.delete();
      }

      cartItems.clear();
    } catch (e) {
      throw Exception('Error clearing cart: $e');
    }
  }
}
