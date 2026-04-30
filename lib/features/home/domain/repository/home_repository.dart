import 'package:marketi/features/home/domain/entity/product_entity.dart';

abstract class HomeRepository {
  Future<List<ProductEntity>> products();
}