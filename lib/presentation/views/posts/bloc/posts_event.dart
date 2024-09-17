part of 'posts_bloc.dart';

class PostsEvent {}

class GetPostsEvent extends PostsEvent {}

class CreatePostEvent extends PostsEvent {
  final String title;
  final String body;
  final int userId;

  CreatePostEvent({
    required this.title,
    required this.body,
    required this.userId,
  });
}
