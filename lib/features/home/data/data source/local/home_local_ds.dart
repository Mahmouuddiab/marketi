import 'package:marketi/features/home/data/models/brand_model.dart';
import 'package:marketi/features/home/data/models/category_model.dart';
import 'package:marketi/features/home/data/models/product_model.dart';

abstract class HomeLocalDs {
  /// PRODUCTS (pagination cache)
  Future<void> cacheProducts(String key, List<ProductModel> products);
  List<ProductModel>? getProducts(String key);

  /// CATEGORIES
  Future<void> cacheCategories(List<CategoryModel> categories);
  List<CategoryModel>? getCategories();

  /// BRANDS
  Future<void> cacheBrands(List<BrandModel> brands);
  List<BrandModel>? getBrands();
}
