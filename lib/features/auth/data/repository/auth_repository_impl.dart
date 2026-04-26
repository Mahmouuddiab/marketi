import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:marketi/core/error/exception.dart';
import 'package:marketi/features/auth/data/data%20source/auth_remote_ds.dart';
import 'package:marketi/features/auth/domain/entity/register_entity.dart';
import 'package:marketi/features/auth/domain/repository/auth_repository.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  AuthRemoteDs authRemoteDs;
  AuthRepositoryImpl(this.authRemoteDs);
  @override
  Future<Either<ServerException, Unit>> register(RegisterEntity registerEntity) async{
    await authRemoteDs.register(registerEntity);
    return Right(unit);
  }

}