class Product {
  final int id;
  final String name;
  final double price;
  final String image;
  final String stripePriceId;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.stripePriceId,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Produit sans nom',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      image: json['image'] ?? 'https://via.placeholder.com/150',
      stripePriceId: json['stripePriceId'] ?? '',
    );
  }
}
