import 'package:injectable/injectable.dart';
import 'package:marketi/features/home/domain/entity/product_entity.dart';
import 'package:marketi/features/home/domain/repository/home_repository.dart';

@injectable
class ProductUseCase {
  HomeRepository repository;
  ProductUseCase(this.repository);
  Future<List<ProductEntity>> call()=> repository.products();
}