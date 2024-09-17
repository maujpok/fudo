import 'package:either_dart/either.dart';
import 'package:fudo/core/error/failures.dart';
import 'package:fudo/core/network/network_info.dart';
import 'package:fudo/domain/api/auth_api.dart';
import 'package:fudo/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApi api;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.api,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, bool>> login(String email, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await api.login(email, password);
        if (response) {
          return const Right(true);
        } else {
          return Left(AuthFailure());
        }
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
