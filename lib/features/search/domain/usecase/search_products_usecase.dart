import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:marketi/features/search/data/model/search_response.dart';
import 'package:marketi/features/search/domain/repository/search_repository.dart';

@injectable
class SearchProductsUseCase {
  final SearchRepository repository;

  SearchProductsUseCase(this.repository);

  Future<Either<String, SearchResponse>> call({
    required String query,
    int limit = 10,
    int skip = 0,
  }) {
    return repository.searchProducts(query: query);
  }
}
