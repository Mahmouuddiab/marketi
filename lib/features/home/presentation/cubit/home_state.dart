import 'package:marketi/features/home/domain/entity/product_entity.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final List<ProductEntity> products;
  HomeSuccess({required this.products});
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}
