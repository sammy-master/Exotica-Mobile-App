/// Product model for Exotica PCMC
class Product {
  final String id;
  final String name;
  final double price;
  final String category;
  final String country;
  final String description;
  final String imageUrl;
  final String? tag; // e.g. IMPORTED, LIMITED EDITION, SUGAR-FREE
  final bool isBestseller;
  final bool isNew;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.country,
    required this.description,
    required this.imageUrl,
    this.tag,
    this.isBestseller = false,
    this.isNew = false,
  });
}

/// Cart item
class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});

  double get subtotal => product.price * quantity;
}
