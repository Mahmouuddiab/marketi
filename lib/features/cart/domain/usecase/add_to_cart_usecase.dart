import 'package:injectable/injectable.dart';
import 'package:marketi/features/cart/domain/repository/cart_repository.dart';

@injectable
class AddToCartUseCase {
  CartRepository repository;
  AddToCartUseCase(this.repository);
  Future<void> call(int productId) => repository.addToCart(productId);
}
