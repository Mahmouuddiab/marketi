import 'package:marketi/features/profile/data/models/profile_model.dart';

abstract class ProfileRemoteDs {
  Future<ProfileModel> getProfile();
}