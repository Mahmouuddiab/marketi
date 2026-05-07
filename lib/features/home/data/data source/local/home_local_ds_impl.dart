import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:marketi/features/home/data/data%20source/local/home_local_ds.dart';
import 'package:marketi/features/home/data/models/brand_model.dart';
import 'package:marketi/features/home/data/models/category_model.dart';
import 'package:marketi/features/home/data/models/product_model.dart';

@Injectable(as: HomeLocalDs)
class HomeLocalDsImpl implements HomeLocalDs {
  final Box box = Hive.box('home_cache');

  /// PRODUCTS (PAGINATION CACHE)

  @override
  Future<void> cacheProducts(String key, List<ProductModel> products) async {
    final data = products.map((e) => e.toJson()).toList();
    await box.put(key, data);
  }

  @override
  List<ProductModel>? getProducts(String key) {
    final data = box.get(key);

    if (data == null) return null;

    return (data as List)
        .map((e) => ProductModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  /// CATEGORIES

  @override
  Future<void> cacheCategories(List<CategoryModel> categories) async {
    final data = categories.map((e) => e.toJson()).toList();
    await box.put('categories', data);
  }

  @override
  List<CategoryModel>? getCategories() {
    final data = box.get('categories');

    if (data == null) return null;

    return (data as List)
        .map((e) => CategoryModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  /// BRANDS

  @override
  Future<void> cacheBrands(List<BrandModel> brands) async {
    final data = brands.map((e) => e.toJson()).toList();
    await box.put('brands', data);
  }

  @override
  List<BrandModel>? getBrands() {
    final data = box.get('brands');

    if (data == null) return null;

    return (data as List)
        .map((e) => BrandModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }
}
