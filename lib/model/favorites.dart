class Favorites {
  final String productId;
  final String title;
  final double price;
  final int quantity;
  final String unitPrice;
  final String image;

  Favorites({
    required this.productId,
    required this.title,
    required this.price,
    required this.quantity,
    required this.unitPrice,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'price': price,
      'quantity': quantity,
      'unitPrice': unitPrice,
      'image': image,
    };
  }

  factory Favorites.fromMap(Map<String, dynamic> map, String productId) {
    return Favorites(
      productId: productId,
      title: map['title'] ?? '',
      price: (map['price'] ?? 0.0).toDouble(),
      quantity: map['quantity'] ?? 0,
      unitPrice: map['unitPrice'] ?? '',
      image: map['image'] ?? '',
    );
  }
}
