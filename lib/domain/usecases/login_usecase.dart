import 'package:either_dart/either.dart';
import 'package:fudo/core/error/failures.dart';
import 'package:fudo/core/usecases/usecase.dart';
import 'package:fudo/domain/repositories/auth_repository.dart';

class LoginUsecase implements UseCase<bool, LoginParams> {
  final AuthRepository _authRepository;

  LoginUsecase(this._authRepository);

  @override
  Future<Either<Failure, bool>> call(LoginParams params) async {
    return await _authRepository.login(params.email, params.password);
  }
}

class LoginParams extends Params {
  final String email;
  final String password;
  LoginParams({
    required this.email,
    required this.password,
  });
}