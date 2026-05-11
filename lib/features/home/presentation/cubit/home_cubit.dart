import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:marketi/features/home/domain/entity/brand_entity.dart';
import 'package:marketi/features/home/domain/entity/category_entity.dart';
import 'package:marketi/features/home/domain/entity/product_entity.dart';
import 'package:marketi/features/home/domain/usecase/brand_usecase.dart';
import 'package:marketi/features/home/domain/usecase/category_usecase.dart';
import 'package:marketi/features/home/domain/usecase/product_by_category_usecase.dart';
import 'package:marketi/features/home/domain/usecase/product_usecase.dart';
import 'package:marketi/features/home/presentation/cubit/home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final ProductUseCase productUseCase;
  final ProductsByCategoryUseCase productsByCategoryUseCase;
  final CategoryUseCase categoryUseCase;
  final BrandUseCase brandUseCase;

  HomeCubit(
    this.productUseCase,
    this.productsByCategoryUseCase,
    this.categoryUseCase,
    this.brandUseCase,
  ) : super(HomeInitial());

  /// HOME DATA

  List<ProductEntity> products = [];

  List<CategoryEntity> categories = [];

  List<BrandEntity> brands = [];

  int skip = 0;

  final int limit = 10;

  bool isLoadingMore = false;

  bool hasMore = true;

  /// CATEGORY PRODUCTS

  List<ProductEntity> categoryProducts = [];

  int categorySkip = 0;

  bool isCategoryLoadingMore = false;

  bool categoryHasMore = true;

  /// FIRST LOAD HOME

  Future<void> getHome() async {
    emit(HomeLoading());

    skip = 0;

    products.clear();

    hasMore = true;

    try {
      final result = await productUseCase.call(skip: skip, limit: limit);

      final categoryResult = await categoryUseCase.call();

      final brandResult = await brandUseCase.call();

      products = result;

      categories = categoryResult;

      brands = brandResult;

      if (result.length < limit) {
        hasMore = false;
      }

      emit(
        HomeSuccess(
          products: products,
          hasMore: hasMore,
          categories: categories,
          brands: brands,
        ),
      );
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  /// LOAD MORE HOME PRODUCTS

  Future<void> loadMore() async {
    if (isLoadingMore || !hasMore) return;

    isLoadingMore = true;

    try {
      skip += limit;

      final result = await productUseCase.call(skip: skip, limit: limit);

      if (result.isEmpty || result.length < limit) {
        hasMore = false;
      }

      products.addAll(result);

      emit(
        HomeSuccess(
          products: List.from(products),
          hasMore: hasMore,
          categories: List.from(categories),
          brands: List.from(brands),
        ),
      );
    } catch (e) {
      emit(HomeError(e.toString()));
    }

    isLoadingMore = false;
  }

  /// GET PRODUCTS BY CATEGORY

  Future<void> getProductsByCategory({required String category}) async {
    emit(HomeLoading());

    categorySkip = 0;

    categoryProducts.clear();

    categoryHasMore = true;

    try {
      final result = await productsByCategoryUseCase.call(
        category: category,
        skip: categorySkip,
        limit: limit,
      );

      categoryProducts = result;

      if (result.length < limit) {
        categoryHasMore = false;
      }

      emit(
        HomeSuccess(
          products: categoryProducts,
          hasMore: categoryHasMore,
          categories: categories,
          brands: brands,
        ),
      );
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  /// LOAD MORE CATEGORY PRODUCTS

  Future<void> loadMoreCategoryProducts({required String category}) async {
    if (isCategoryLoadingMore || !categoryHasMore) {
      return;
    }

    isCategoryLoadingMore = true;

    try {
      categorySkip += limit;

      final result = await productsByCategoryUseCase.call(
        category: category,
        skip: categorySkip,
        limit: limit,
      );

      if (result.isEmpty || result.length < limit) {
        categoryHasMore = false;
      }

      categoryProducts.addAll(result);

      emit(
        HomeSuccess(
          products: List.from(categoryProducts),
          hasMore: categoryHasMore,
          categories: List.from(categories),
          brands: List.from(brands),
        ),
      );
    } catch (e) {
      emit(HomeError(e.toString()));
    }

    isCategoryLoadingMore = false;
  }

  /// REFRESH HOME

  Future<void> refresh() async {
    await getHome();
  }

  /// REFRESH CATEGORY PRODUCTS

  Future<void> refreshCategoryProducts({required String category}) async {
    await getProductsByCategory(category: category);
  }
}
