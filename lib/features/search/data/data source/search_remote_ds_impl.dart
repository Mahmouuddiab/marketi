import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:marketi/core/cache/cache_helper.dart';
import 'package:marketi/core/error/exception.dart';
import 'package:marketi/core/network/dio_helper.dart';
import 'package:marketi/features/search/data/data%20source/search_remote_ds.dart';
import 'package:marketi/features/search/data/model/search_response.dart';

@Injectable(as: SearchRemoteDs)
class SearchRemoteDsImpl implements SearchRemoteDs {
  @override
  Future<Either<String, SearchResponse>> searchProducts({
    required String query,
    int limit = 10,
    int skip = 0,
  }) async {
    try {
      final token = await CacheHelper.getToken();
      final response = await DioHelper.post(
        url: "https://supermarket-dan1.onrender.com/api/v1/home/productsFilter",
        data: {
          "search": query,
          "skip": skip,
          "limit": limit
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          }
        )
      );

      // Check for null or unexpected status codes if DioHelper doesn't throw
      if (response.data != null) {
        return Right(SearchResponse.fromJson(response.data));
      } else {
        return const Left("Unexpected empty response from server");
      }

    } on ServerException catch (e) {
      return Left(e.message);
    } catch (e) {
      // Catch-all for parsing errors or unexpected issues
      return Left("An unexpected error occurred: ${e.toString()}");
    }
  }
}