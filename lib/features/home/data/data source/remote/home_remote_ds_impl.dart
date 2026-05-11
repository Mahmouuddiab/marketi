import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:marketi/core/cache/cache_helper.dart';
import 'package:marketi/core/network/dio_helper.dart';
import 'package:marketi/features/home/data/data%20source/remote/home_remote_ds.dart';
import 'package:marketi/features/home/data/models/brand_model.dart';
import 'package:marketi/features/home/data/models/category_model.dart';
import 'package:marketi/features/home/data/models/product_model.dart';

@Injectable(as: HomeRemoteDs)
class HomeRemoteDsImpl implements HomeRemoteDs {
  @override
  Future<List<ProductModel>> products({
    required int skip,
    required int limit,
  }) async {
    final token = await CacheHelper.getToken();
    final response = await DioHelper.get(
      url: "https://supermarket-dan1.onrender.com/api/v1/home/products",
      queryParameters: {'skip': skip, 'limit': limit},
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      ),
    );
    if (response.statusCode == 200) {
      print("products: ${response.data}");
      final List data = response.data['list'];
      return data.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw Exception('Server error: ${response.statusCode}');
    }
  }

  @override
  Future<List<CategoryModel>> categories() async {
    final token = await CacheHelper.getToken();
    final response = await DioHelper.get(
      url: "https://supermarket-dan1.onrender.com/api/v1/home/categories",
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      ),
    );
    if (response.statusCode == 200) {
      print("categories: ${response.data}");
      final List data = response.data['list'];
      return data.map((json) => CategoryModel.fromJson(json)).toList();
    } else {
      throw Exception('Server error: ${response.statusCode}');
    }
  }

  @override
  Future<List<BrandModel>> brands() async{
    final token = await CacheHelper.getToken();
    final response = await DioHelper.get(
        url: "https://supermarket-dan1.onrender.com/api/v1/home/brands",
        options: Options(
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      ),

    );
    if(response.statusCode == 200){
      print("brands: ${response.data}");
      final List data = response.data['list'];
      return data.map((json) => BrandModel.fromJson(json)).toList();
    }
    else{
      throw Exception('Server error: ${response.statusCode}');
    }
  }

  @override
  Future<List<ProductModel>> productsByCategory({
    required String category,
    required int skip,
    required int limit,
  }) async {

    final token = await CacheHelper.getToken();

    final response = await DioHelper.get(
      url:
      "https://supermarket-dan1.onrender.com/api/v1/home/products/category/$category",
      queryParameters: {
        'skip': skip,
        'limit': limit,
      },
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      ),
    );

    if (response.statusCode == 200) {

      print("products by category: ${response.data}");

      final List data = response.data['list'];

      return data
          .map((json) => ProductModel.fromJson(json))
          .toList();

    } else {

      throw Exception(
        'Server error: ${response.statusCode}',
      );
    }
  }

}
