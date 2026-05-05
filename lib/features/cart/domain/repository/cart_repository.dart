import 'package:marketi/features/home/domain/entity/product_entity.dart';

abstract class CartRepository {
  Future<void> addToCart(int productId);
  Future<List<ProductEntity>> getCart();
}