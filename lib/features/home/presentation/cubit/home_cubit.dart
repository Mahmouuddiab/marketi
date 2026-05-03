import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:marketi/features/home/domain/entity/category_entity.dart';
import 'package:marketi/features/home/domain/entity/product_entity.dart';
import 'package:marketi/features/home/domain/usecase/category_usecase.dart';
import 'package:marketi/features/home/domain/usecase/product_usecase.dart';
import 'package:marketi/features/home/presentation/cubit/home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final ProductUseCase productUseCase;
  final CategoryUseCase categoryUseCase;
  HomeCubit(this.productUseCase,this.categoryUseCase) : super(HomeInitial());

  List<ProductEntity> products = [];
  List<CategoryEntity> categories = [];

  int skip = 0;
  final int limit = 10;

  bool isLoadingMore = false;
  bool hasMore = true;

  ///  First load
  Future<void> getHome() async {
    emit(HomeLoading());

    skip = 0;
    products.clear();
    hasMore = true;

    try {
      final result = await productUseCase.call(
        skip: skip,
        limit: limit,
      );
      final categoryResult = await categoryUseCase.call();
      products = result;
      categories = categoryResult;
      if (result.length < limit) {
        hasMore = false;
      }

      emit(HomeSuccess(
        products: products,
        hasMore: hasMore,
        categories: categories,
      ));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  ///  Load more (pagination)
  Future<void> loadMore() async {
    if (isLoadingMore || !hasMore) return;

    isLoadingMore = true;

    try {
      skip += limit;

      final result = await productUseCase.call(
        skip: skip,
        limit: limit,
      );

      if (result.isEmpty || result.length < limit) {
        hasMore = false;
      }

      products.addAll(result);

      emit(HomeSuccess(
        products: List.from(products),
        hasMore: hasMore,
        categories: List.from(categories),
      ));
    } catch (e) {
      emit(HomeError(e.toString()));
    }

    isLoadingMore = false;
  }

  ///  Optional: refresh
  Future<void> refresh() async {
    await getHome();
  }
}