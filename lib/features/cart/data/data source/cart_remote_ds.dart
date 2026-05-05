import 'package:marketi/features/home/data/models/product_model.dart';

abstract class CartRemoteDs {
  Future<void> addToCart(int productId);
  Future<List<ProductModel>> getCart();
}