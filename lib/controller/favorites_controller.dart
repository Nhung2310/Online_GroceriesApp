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

  Future<void> fetchFavoritesItems() async {
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
      print('Fetched ${cartItemsSnapshot.docs.length} favorite items');
      var favorite =
          cartItemsSnapshot.docs.map((doc) {
            return Favorites.fromMap(
              doc.data() as Map<String, dynamic>,
              doc.id,
            );
          }).toList();

      favoritesList.assignAll(favorite);
      isLoading.value = false;
    } catch (e) {
      print('Caught error: $e');
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

        await fetchFavoritesItems();
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

      await fetchFavoritesItems();
    } catch (e) {
      throw Exception('Error removing from favorites: $e');
    }
  }
}
