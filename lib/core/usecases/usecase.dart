import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:fudo/core/error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class Params extends Equatable {
  @override
  List<Object> get props => [];
}

class NoParams extends Params {}
