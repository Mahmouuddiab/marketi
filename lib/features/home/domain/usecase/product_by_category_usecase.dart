import 'package:injectable/injectable.dart';
import 'package:marketi/features/home/domain/entity/product_entity.dart';
import 'package:marketi/features/home/domain/repository/home_repository.dart';

@injectable
class ProductsByCategoryUseCase {
  HomeRepository repository;

  ProductsByCategoryUseCase(this.repository);

  Future<List<ProductEntity>> call({
    required String category,
    required int skip,
    required int limit,
  }) => repository.productsByCategory(
    category: category,
    skip: skip,
    limit: limit,
  );
}
