part of 'posts_bloc.dart';

class PostsEvent {}

class GetPostsEvent extends PostsEvent {}

class GetUsersEvent extends PostsEvent {}

class CreatePostEvent extends PostsEvent {
  final String title;
  final String body;
  final int userId;
  final void Function() onPostCreated;

  CreatePostEvent({
    required this.title,
    required this.body,
    required this.userId,
    required this.onPostCreated,
  });
}

class FilterPostsByUserNameEvent extends PostsEvent {
  final String query;

  FilterPostsByUserNameEvent({required this.query});
}

class ResetPostsSearchEvent extends PostsEvent {}