class ProductVariant {
  final String id;
  final String attributeName;
  final String attributeValue;
  final int stock;
  final String sku;

  ProductVariant({
    required this.id,
    required this.attributeName,
    required this.attributeValue,
    required this.stock,
    required this.sku,
  });
}

class Product {
  final String id;
  final String name;
  final String description;
  final String category;
  final String sku;
  final double priceUsd;
  final int initialQuantity;
  final int minStockAlert;
  final String? imageUrl;
  final List<ProductVariant> variants;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.sku,
    required this.priceUsd,
    required this.initialQuantity,
    required this.minStockAlert,
    this.imageUrl,
    this.variants = const [],
  });

  int get totalStock => variants.fold(0, (sum, v) => sum + v.stock);
}
