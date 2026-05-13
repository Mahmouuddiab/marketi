import 'package:injectable/injectable.dart';
import 'package:marketi/features/home/domain/entity/product_entity.dart';
import 'package:marketi/features/home/domain/repository/home_repository.dart';

@injectable
class ProductsByBrandUseCase {
  HomeRepository repository;

  ProductsByBrandUseCase(this.repository);

  Future<List<ProductEntity>> call({
    required String brand,
    required int skip,
    required int limit,
  }) => repository.productsByBrand(
    brand: brand,
    skip: skip,
    limit: limit,
  );
}
