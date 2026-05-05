import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:marketi/core/cache/cache_helper.dart';
import 'package:marketi/core/network/dio_helper.dart';
import 'package:marketi/features/cart/data/data%20source/cart_remote_ds.dart';
import 'package:marketi/features/home/data/models/product_model.dart';

@Injectable(as: CartRemoteDs)
class CartRemoteDsImpl implements CartRemoteDs {
  @override
  Future<void> addToCart(int productId) async {
    final token = await CacheHelper.getToken();

    try {
      final response = await DioHelper.post(
        url: "https://supermarket-dan1.onrender.com/api/v1/user/addCart",
        data: {
          "id": productId,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return;
      } else {
        throw Exception("Failed to add product to cart");
      }
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["message"] ?? "Network error occurred",
      );
    }
  }

  @override
  Future<List<ProductModel>> getCart() async{
    final token = await CacheHelper.getToken();
    final response = await DioHelper.get(
        url: "https://supermarket-dan1.onrender.com/api/v1/user/getCart",
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        }
      )
    );
    if(response.statusCode == 200){
      print("Cart Products : ${response.data}");
      final List data = response.data['list'];
      return data.map((json) => ProductModel.fromJson(json)).toList();
    }
    else{
      throw Exception('Server error: ${response.statusCode}');
    }
  }
}