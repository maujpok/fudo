import 'package:either_dart/either.dart';
import 'package:fudo/core/error/failures.dart';
import 'package:fudo/core/network/network_info.dart';
import 'package:fudo/data/models/_models.dart';
import 'package:fudo/domain/api/post_api.dart';
import 'package:fudo/domain/repositories/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final PostApi api;
  final NetworkInfo networkInfo;

  PostRepositoryImpl({
    required this.api,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<PostModel>>> getPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await api.getPosts();
        return Right(response);
      } on ServerException {
        return Left(ServerFailure());
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<UserModel>>> getUsers() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await api.getUsers();
        return Right(response);
      } on ServerException {
        return Left(ServerFailure());
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> createPost({
    required String title,
    required String body,
    required int userId,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await api.createPost(
          title: title,
          body: body,
          userId: userId,
        );
        return Right(response);
      } on ServerException {
        return Left(ServerFailure());
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
