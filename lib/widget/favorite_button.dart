import 'package:flutter/material.dart';
import 'package:online_groceries_app/model/product.dart';
import 'package:online_groceries_app/controller/favorites_controller.dart';
import 'package:online_groceries_app/model/favorites.dart';

class FavoriteButton extends StatefulWidget {
  final Product product;
  final FavoritesController favoritesController;

  const FavoriteButton({
    Key? key,
    required this.product,
    required this.favoritesController,
  }) : super(key: key);

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    checkIfFavorite();
  }

  Future<void> checkIfFavorite() async {
    final items = await widget.favoritesController.getFavoritesItems();
    final exists = items.any((item) => item.productId == widget.product.id);
    setState(() {
      isFavorite = exists;
    });
  }

  Future<void> toggleFavorite() async {
    final product = widget.product;
    if (isFavorite) {
      await widget.favoritesController.removeFromFavorites(product.id);
    } else {
      final favoritesItem = Favorites(
        productId: product.id,
        title: product.title,
        price: product.price,
        quantity: 1,
        unitPrice: product.unitPrice,
        image: product.image,
      );
      await widget.favoritesController.addToFavorites(favoritesItem);
    }

    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border_outlined,
        color: isFavorite ? Colors.red : Colors.grey,
      ),
      onPressed: toggleFavorite,
    );
  }
}
