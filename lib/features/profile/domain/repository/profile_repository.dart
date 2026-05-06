import 'package:marketi/features/profile/domain/entity/profile_entity.dart';

abstract class ProfileRepository {
  Future<ProfileEntity> getProfile();
}