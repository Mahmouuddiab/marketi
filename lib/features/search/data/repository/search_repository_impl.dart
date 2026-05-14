import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:marketi/features/search/data/data%20source/search_remote_ds.dart';
import 'package:marketi/features/search/data/model/search_response.dart';
import 'package:marketi/features/search/domain/repository/search_repository.dart';

@Injectable(as: SearchRepository)
class SearchRepositoryImpl implements SearchRepository {
  SearchRemoteDs remote;
  SearchRepositoryImpl(this.remote);
  @override
  Future<Either<String, SearchResponse>> searchProducts({
    required String query,
    int limit = 10,
    int skip = 0,
  }) async {
    final dto = await remote.searchProducts(
      query: query,
      limit: limit,
      skip: skip,
    );
    return dto;
  }
}
