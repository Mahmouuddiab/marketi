import 'package:dartz/dartz.dart';
import 'package:marketi/core/error/exception.dart';
import 'package:marketi/features/auth/domain/entity/login_entity.dart';
import 'package:marketi/features/auth/domain/entity/register_entity.dart';

abstract class AuthRepository {
  Future<Either<ServerException,Unit>> register(RegisterEntity registerEntity);
  Future<Either<ServerException,Unit>> login(LoginEntity loginEntity);
}