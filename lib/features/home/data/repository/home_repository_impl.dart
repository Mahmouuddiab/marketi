import 'package:injectable/injectable.dart';
import 'package:marketi/features/home/data/data%20source/local/home_local_ds.dart';
import 'package:marketi/features/home/data/data%20source/remote/home_remote_ds.dart';
import 'package:marketi/features/home/data/models/brand_model.dart';
import 'package:marketi/features/home/data/models/category_model.dart';
import 'package:marketi/features/home/data/models/product_model.dart';
import 'package:marketi/features/home/domain/repository/home_repository.dart';

@Injectable(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDs remote;
  final HomeLocalDs local;

  HomeRepositoryImpl(this.remote, this.local);

  /// PRODUCTS

  @override
  Future<List<ProductModel>> products({
    required int skip,
    required int limit,
  }) async {
    final cacheKey = 'products_${skip}_$limit';

    // 1. CACHE
    final cached = local.getProducts(cacheKey);

    if (cached != null && cached.isNotEmpty) {
      return cached;
    }

    // 2. REMOTE
    final response = await remote.products(
      skip: skip,
      limit: limit,
    );

    // 3. CACHE
    await local.cacheProducts(cacheKey, response);

    return response;
  }

  /// CATEGORIES

  @override
  Future<List<CategoryModel>> categories() async {
    final cached = local.getCategories();

    if (cached != null && cached.isNotEmpty) {
      return cached;
    }

    final response = await remote.categories();

    await local.cacheCategories(response);

    return response;
  }

  /// BRANDS

  @override
  Future<List<BrandModel>> brands() async {
    final cached = local.getBrands();

    if (cached != null && cached.isNotEmpty) {
      return cached;
    }

    final response = await remote.brands();

    await local.cacheBrands(response);

    return response;
  }
}