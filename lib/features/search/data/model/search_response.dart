class SearchResponse {
  final List<ProductSearch> list;
  final int total;
  final int skip;
  final int limit;

  SearchResponse({
    required this.list,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory SearchResponse.fromJson(Map<String, dynamic> json) {
    return SearchResponse(
      list: (json['list'] as List)
          .map((e) => ProductSearch.fromJson(e))
          .toList(),
      total: json['total'],
      skip: json['skip'],
      limit: json['limit'],
    );
  }
}

class ProductSearch {
  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final List<String> tags;
  final String brand;
  final String sku;
  final int weight;
  final Dimensions dimensions;
  final String? warrantyInformation; // <- nullable
  final String? shippingInformation; // <- nullable
  final String? availabilityStatus; // <- nullable
  final List<Review> reviews;
  final String? returnPolicy; // <- nullable
  final int minimumOrderQuantity;
  final Meta meta;
  final List<String> images;
  final String? thumbnail; // <- nullable

  ProductSearch({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.tags,
    required this.brand,
    required this.sku,
    required this.weight,
    required this.dimensions,
    this.warrantyInformation,
    this.shippingInformation,
    this.availabilityStatus,
    required this.reviews,
    this.returnPolicy,
    required this.minimumOrderQuantity,
    required this.meta,
    required this.images,
    this.thumbnail,
  });

  factory ProductSearch.fromJson(Map<String, dynamic> json) {
    return ProductSearch(
      id: json['id'],
      title: json['title'] ?? "",
      description: json['description'] ?? "",
      category: json['category'] ?? "",
      price: (json['price'] as num?)?.toDouble() ?? 0,
      discountPercentage: (json['discountPercentage'] as num?)?.toDouble() ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      stock: json['stock'] ?? 0,
      tags: List<String>.from(json['tags'] ?? []),
      brand: json['brand'] ?? "",
      sku: json['sku'] ?? "",
      weight: json['weight'] ?? 0,
      dimensions: Dimensions.fromJson(json['dimensions'] ?? {}),
      warrantyInformation: json['warrantyInformation'],
      shippingInformation: json['shippingInformation'],
      availabilityStatus: json['availabilityStatus'],
      reviews: (json['reviews'] as List? ?? [])
          .map((e) => Review.fromJson(e))
          .toList(),
      returnPolicy: json['returnPolicy'],
      minimumOrderQuantity: json['minimumOrderQuantity'] ?? 0,
      meta: Meta.fromJson(json['meta'] ?? {}),
      images: List<String>.from(json['images'] ?? []),
      thumbnail: json['thumbnail'],
    );
  }
}

class Dimensions {
  final double width;
  final double height;
  final double depth;

  Dimensions({
    required this.width,
    required this.height,
    required this.depth,
  });

  factory Dimensions.fromJson(Map<String, dynamic> json) {
    return Dimensions(
      width: (json['width'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
      depth: (json['depth'] as num).toDouble(),
    );
  }
}

class Review {
  final int rating;
  final String comment;
  final String date;
  final String reviewerName;
  final String reviewerEmail;

  Review({
    required this.rating,
    required this.comment,
    required this.date,
    required this.reviewerName,
    required this.reviewerEmail,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      rating: json['rating'],
      comment: json['comment'],
      date: json['date'],
      reviewerName: json['reviewerName'],
      reviewerEmail: json['reviewerEmail'],
    );
  }
}

class Meta {
  final String createdAt;
  final String updatedAt;
  final String barcode;
  final String qrCode;

  Meta({
    required this.createdAt,
    required this.updatedAt,
    required this.barcode,
    required this.qrCode,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      barcode: json['barcode'],
      qrCode: json['qrCode'],
    );
  }
}