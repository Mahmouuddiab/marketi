import '../../domain/entity/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    required super.id,
    required super.title,
    required super.description,
    required super.category,
    required super.price,
    required super.discountPercentage,
    required super.rating,
    required super.stock,
    required super.tags,
    required super.brand,
    required super.sku,
    required super.weight,
    required super.warrantyInformation,
    required super.shippingInformation,
    required super.availabilityStatus,
    required super.returnPolicy,
    required super.minimumOrderQuantity,
    required super.images,
    required super.thumbnail,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      discountPercentage: (json['discountPercentage'] ?? 0).toInt(),
      rating: (json['rating'] ?? 0).toDouble(),
      stock: json['stock'] ?? 0,

      tags: (json['tags'] as List?)
          ?.map((e) => e.toString())
          .toList() ??
          [],

      brand: json['brand'] ?? '',
      sku: json['sku'] ?? '',
      weight: json['weight'] ?? 0,

      warrantyInformation: json['warrantyInformation'] ?? '',
      shippingInformation: json['shippingInformation'] ?? '',
      availabilityStatus: json['availabilityStatus'] ?? '',
      returnPolicy: json['returnPolicy'] ?? '',
      minimumOrderQuantity: json['minimumOrderQuantity'] ?? 0,

      images: (json['images'] as List?)
          ?.map((e) => e.toString())
          .toList() ??
          [],

      thumbnail: json['thumbnail'] ?? '',
    );
  }
}