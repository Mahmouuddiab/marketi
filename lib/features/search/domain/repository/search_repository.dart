import 'package:dartz/dartz.dart';
import 'package:marketi/features/search/data/model/search_response.dart';

abstract class SearchRepository {
  Future<Either<String,SearchResponse>> searchProducts({
    required String query,
    int limit = 10,
    int skip = 0,
  });
}
