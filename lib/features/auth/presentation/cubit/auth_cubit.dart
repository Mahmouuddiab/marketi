import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:marketi/features/auth/domain/entity/register_entity.dart';
import 'package:marketi/features/auth/domain/usecase/register_usecase.dart';
import 'package:marketi/features/auth/presentation/cubit/auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState>{
  RegisterUseCase registerUseCase;
  AuthCubit(this.registerUseCase):super(AuthInitialState());

  Future<void> register(RegisterEntity registerEntity)async{
    emit(RegisterLoadingState());
    final response = await registerUseCase.call(registerEntity);
    return response.fold(
          (l) {
        emit(RegisterErrorState(error: "can't register ${l.message}"));
      },
          (r) {
        emit(RegisterSuccessState());
      },
    ) ;
  }
}