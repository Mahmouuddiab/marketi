import 'package:marketi/features/home/domain/entity/category_entity.dart';
import 'package:marketi/features/home/domain/entity/product_entity.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final List<ProductEntity> products;
  final List<CategoryEntity> categories;
  final bool hasMore;

  HomeSuccess({
    required this.products,
    this.hasMore = true,
    required this.categories
  });
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}