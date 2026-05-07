import 'package:marketi/features/home/domain/entity/brand_entity.dart';

class BrandModel extends BrandEntity {
  BrandModel({
    required super.name,
    required super.emoji,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      name: json['name'] ?? '',
      emoji: json['emoji'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'emoji': emoji,
    };
  }
}