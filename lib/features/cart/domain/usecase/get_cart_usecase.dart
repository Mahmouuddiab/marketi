import 'package:injectable/injectable.dart';
import 'package:marketi/features/cart/domain/repository/cart_repository.dart';
import '../../../home/domain/entity/product_entity.dart';

@injectable
class GetCartUseCase {
  CartRepository repository;
  GetCartUseCase(this.repository);
  Future<List<ProductEntity>> call() => repository.getCart();
}
