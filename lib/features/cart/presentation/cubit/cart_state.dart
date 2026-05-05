import 'package:marketi/features/home/domain/entity/product_entity.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class AddToCartLoading extends CartState {}
class AddToCartSuccess extends CartState {}
class AddToCartError extends CartState {
  final String message;
  AddToCartError(this.message);
}

class GetCartLoading extends CartState {}
class GetCartSuccess extends CartState {
  final List<ProductEntity> cartProducts;
  GetCartSuccess({required this.cartProducts});
}
class GetCartError extends CartState {
  final String message;
  GetCartError(this.message);
}