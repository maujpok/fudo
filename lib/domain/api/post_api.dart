abstract class PostApi {
  Future<dynamic> getPosts();
  Future<dynamic> createPost({
    required String title,
    required String body,
    required int userId,
  });
}
