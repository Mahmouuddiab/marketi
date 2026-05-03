import 'package:marketi/features/home/domain/entity/category_entity.dart';
import 'package:marketi/features/home/domain/entity/product_entity.dart';

abstract class HomeRepository {
  Future<List<ProductEntity>> products({
    required int skip,
    required int limit
  });

  Future<List<CategoryEntity>> categories();
}
