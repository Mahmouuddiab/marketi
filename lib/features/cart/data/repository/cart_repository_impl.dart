import 'package:injectable/injectable.dart';
import 'package:marketi/features/cart/data/data%20source/cart_remote_ds.dart';
import 'package:marketi/features/cart/domain/repository/cart_repository.dart';
import 'package:marketi/features/home/domain/entity/product_entity.dart';

@Injectable(as: CartRepository)
class CartRepositoryImpl implements CartRepository {
  CartRemoteDs remote;
  CartRepositoryImpl(this.remote);
  @override
  Future<void> addToCart(int productId) async{
    return await remote.addToCart(productId) ;
  }

  @override
  Future<List<ProductEntity>> getCart() async{
    final dto = await remote.getCart();
    return dto ;
  }
  
}