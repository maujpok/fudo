import 'package:either_dart/either.dart';
import 'package:fudo/core/error/failures.dart';
import 'package:fudo/core/usecases/usecase.dart';
import 'package:fudo/data/models/_models.dart';
import 'package:fudo/domain/repositories/post_repository.dart';

class GetPostsUsecase implements UseCase<List<PostModel>, NoParams> {
  final PostRepository _postRepository;

  GetPostsUsecase(this._postRepository);

  @override
  Future<Either<Failure, List<PostModel>>> call(NoParams params) async {
    return await _postRepository.getPosts();
  }
}

class CreatePostUsecase implements UseCase<bool, CreatePostParams> {
  final PostRepository _postRepository;

  CreatePostUsecase(this._postRepository);

  @override
  Future<Either<Failure, bool>> call(CreatePostParams params) async {
    return await _postRepository.createPost(
      title: params.title,
      body: params.body,
      userId: params.userId,
    );
  }
}

class CreatePostParams extends Params {
  final String title;
  final String body;
  final int userId;

  CreatePostParams({
    required this.title,
    required this.body,
    required this.userId,
  });
}

class GetUsersUsecase implements UseCase<List<UserModel>, NoParams> {
  final PostRepository _postRepository;

  GetUsersUsecase(this._postRepository);

  @override
  Future<Either<Failure, List<UserModel>>> call(NoParams params) async {
    return await _postRepository.getUsers();
  }
}
