import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:marketi/features/search/domain/usecase/search_products_usecase.dart';
import 'package:marketi/features/search/presentation/cubit/search_state.dart';

@injectable
class SearchCubit extends Cubit<SearchState> {
  final SearchProductsUseCase searchProductsUseCase;

  SearchCubit(this.searchProductsUseCase) : super(SearchInitial());

  Future<void> searchProducts({
    required String query,
    int limit = 10,
    int skip = 0,
  }) async {
    if (query.trim().isEmpty) {
      emit(SearchInitial());
      return;
    }

    emit(SearchLoading());

    final result = await searchProductsUseCase.call(
      query: query,
      limit: limit,
      skip: skip,
    );

    result.fold(
      (error) => emit(SearchError(error)),
      (response) => emit(SearchSuccess(response)),
    );
  }
}
