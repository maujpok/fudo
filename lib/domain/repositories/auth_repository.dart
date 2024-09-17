import 'package:either_dart/either.dart';
import 'package:fudo/core/error/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure, bool>> login(String email, String password);
}
