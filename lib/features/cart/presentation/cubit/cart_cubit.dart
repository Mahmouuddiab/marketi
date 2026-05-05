import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:marketi/features/cart/domain/usecase/add_to_cart_usecase.dart';
import 'package:marketi/features/cart/domain/usecase/get_cart_usecase.dart';
import 'package:marketi/features/cart/presentation/cubit/cart_state.dart';

@injectable
class CartCubit extends Cubit<CartState> {
  final AddToCartUseCase addToCartUseCase;
  final GetCartUseCase getCartUseCase;
  CartCubit(this.addToCartUseCase, this.getCartUseCase) : super(CartInitial());

  Future<void> addToCart(int productId) async {
    emit(AddToCartLoading());

    try {
      await addToCartUseCase(productId);
      emit(AddToCartSuccess());
    } catch (e) {
      emit(AddToCartError(e.toString()));
    }
  }
  Future<void> getCartProducts()async{
    emit(GetCartLoading());
    try{
      final cartProducts = await getCartUseCase.call();
      emit(GetCartSuccess(cartProducts: cartProducts));
    }
    catch(e){
      emit(GetCartError(e.toString()));
    }
  }
}
