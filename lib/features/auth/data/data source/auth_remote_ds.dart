import 'package:dartz/dartz.dart';
import 'package:marketi/features/auth/domain/entity/register_entity.dart';

abstract class AuthRemoteDs {
  Future<Unit> register (RegisterEntity registerEntity);
}