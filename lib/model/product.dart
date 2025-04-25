class Product {
  String id;
  String title;
  String description;
  String image;
  bool isBestSelling;
  bool isExclusiveOffer;
  bool isGroceries;
  double price;
  String unitPrice;
  String type;
  double review;
  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.isBestSelling,
    required this.isExclusiveOffer,
    required this.isGroceries,
    required this.price,
    required this.unitPrice,
    required this.type,
    required this.review,
  });

  factory Product.fromMap(Map<String, dynamic> data) {
    return Product(
      id: data['id'] as String? ?? '',
      title: data['title'] as String? ?? '',
      description: data['description'] as String? ?? '',
      image: data['image'] as String? ?? '',
      isBestSelling: data['isBestSelling'] as bool? ?? false,
      isExclusiveOffer: data['isExclusiveOffer'] as bool? ?? false,
      isGroceries: data['isGroceries'] as bool? ?? false,
      price: (data['price'] as num?)?.toDouble() ?? 0.0,
      unitPrice: data['unitPrice'] as String? ?? '',
      type: data['type'] as String? ?? '',
      review: (data['review'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image': image,
      'isBestSelling': isBestSelling,
      'isExclusiveOffer': isExclusiveOffer,
      'isGroceries': isGroceries,
      'price': price,
      'unitPrice': unitPrice,
      'type': type,
      'review': review,
    };
  }
}
