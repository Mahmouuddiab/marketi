import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:marketi/core/error/exception.dart';
import 'package:marketi/features/auth/domain/entity/login_entity.dart';
import 'package:marketi/features/auth/domain/repository/auth_repository.dart';

@injectable
class LoginUseCase {
  AuthRepository authRepository;
  LoginUseCase(this.authRepository);
  Future<Either<ServerException, Unit>> call(LoginEntity loginEntity) =>
      authRepository.login(loginEntity);
}
