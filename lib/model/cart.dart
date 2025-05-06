class Cart {
  final String productId;
  final String title;
  final double price;
  final int quantity;
  final String unitPrice;
  final String image;

  Cart({
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

  factory Cart.fromMap(Map<String, dynamic> map, String productId) {
    return Cart(
      productId: productId,
      title: map['title'] ?? '',
      price: (map['price'] ?? 0.0).toDouble(),
      quantity: map['quantity'] ?? 0,
      unitPrice: map['unitPrice'] ?? '',
      image: map['image'] ?? '',
    );
  }
}
