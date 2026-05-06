import 'package:marketi/features/profile/domain/entity/profile_entity.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}
class ProfileSuccess extends ProfileState {
  final ProfileEntity user;
  ProfileSuccess(this.user);
}

class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}