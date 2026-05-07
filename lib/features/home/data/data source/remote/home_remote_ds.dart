import 'package:marketi/features/home/data/models/brand_model.dart';
import 'package:marketi/features/home/data/models/category_model.dart';
import 'package:marketi/features/home/data/models/product_model.dart';

abstract class HomeRemoteDs {
  Future<List<ProductModel>> products({
    required int skip,
    required int limit,
  });

  Future<List<CategoryModel>> categories();
  Future<List<BrandModel>> brands();
}