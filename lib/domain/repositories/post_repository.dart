import 'package:either_dart/either.dart';
import 'package:fudo/core/error/failures.dart';
import 'package:fudo/data/models/post_model.dart';

abstract class PostRepository {
  Future<Either<Failure, List<PostModel>>> getPosts();

  Future<Either<Failure, bool>> createPost({
    required String title,
    required String body,
    required int userId,
  });
}
