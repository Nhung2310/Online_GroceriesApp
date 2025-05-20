import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:online_groceries_app/model/favorites.dart';

class FavoritesController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
  final isLoading = true.obs;
  final favoritesList = <Favorites>[].obs;

  @override
  void onInit() {
    super.onInit();

    fetchFavoritesItems();
  }

  Future<List<Favorites>> fetchFavoritesItems() async {
    if (userId.isEmpty) {
      throw Exception('User not logged in');
    }

    try {
      QuerySnapshot cartItemsSnapshot =
          await _firestore
              .collection('user')
              .doc(userId)
              .collection('favorites')
              .get();

      return cartItemsSnapshot.docs.map((doc) {
        return Favorites.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    } catch (e) {
      throw Exception('Error fetching favorites: $e');
    }
  }

  Future<void> addToFavorites(Favorites cartItem) async {
    if (userId.isEmpty) {
      throw Exception('User not logged in');
    }

    try {
      DocumentReference cartItemRef = _firestore
          .collection('user')
          .doc(userId)
          .collection('favorites')
          .doc(cartItem.productId);

      DocumentSnapshot cartItemSnapshot = await cartItemRef.get();

      if (!cartItemSnapshot.exists) {
        await cartItemRef.set(cartItem.toMap());
      }
    } catch (e) {
      throw Exception('Error adding to favorites: $e');
    }
  }

  Future<void> removeFromFavorites(String productId) async {
    if (userId.isEmpty) {
      throw Exception('User not logged in');
    }

    try {
      await _firestore
          .collection('user')
          .doc(userId)
          .collection('favorites')
          .doc(productId)
          .delete();
    } catch (e) {
      throw Exception('Error removing from favorites: $e');
    }
  }
}
