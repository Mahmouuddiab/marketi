import 'package:injectable/injectable.dart';
import 'package:marketi/features/profile/domain/entity/profile_entity.dart';
import 'package:marketi/features/profile/domain/repository/profile_repository.dart';

@injectable
class ProfileUseCase {
  ProfileRepository repository;
  ProfileUseCase(this.repository);
  Future<ProfileEntity> call() => repository.getProfile();
}
