import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:marketi/core/error/exception.dart';
import 'package:marketi/features/auth/domain/entity/register_entity.dart';
import 'package:marketi/features/auth/domain/repository/auth_repository.dart';

@injectable
class RegisterUseCase {
  AuthRepository authRepository;
  RegisterUseCase(this.authRepository);
  Future<Either<ServerException, Unit>> call(RegisterEntity registerEntity) =>
      authRepository.register(registerEntity);
}
