import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:marketi/features/profile/domain/usecase/profile_usecase.dart';
import 'package:marketi/features/profile/presentation/cubit/profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final ProfileUseCase profileUseCase;

  ProfileCubit(this.profileUseCase) : super(ProfileInitial());

  Future<void> getProfile() async {
    emit(ProfileLoading());
    try {
      final  user = await profileUseCase.call();
      emit(ProfileSuccess(user));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}