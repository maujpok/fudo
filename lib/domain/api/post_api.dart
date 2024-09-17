import 'package:fudo/data/models/_models.dart';

abstract class PostApi {
  Future<List<PostModel>> getPosts();
  Future<List<UserModel>> getUsers();
  Future<bool> createPost({
    required String title,
    required String body,
    required int userId,
  });
}
