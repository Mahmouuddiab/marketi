import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:marketi/features/home/domain/usecase/product_usecase.dart';
import 'package:marketi/features/home/presentation/cubit/home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState>{
  ProductUseCase productUseCase;
  HomeCubit(this.productUseCase):super(HomeInitial());

  Future<void> getHome()async{
    emit(HomeLoading());
    try{
      final products = await productUseCase.call();
      emit(HomeSuccess(products: products));
    }
    catch(e){
      emit(HomeError(e.toString()));
    }
  }
}