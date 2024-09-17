part of 'posts_bloc.dart';

class PostsState extends Equatable {
  const PostsState({
    this.loading = false,
    this.postList,
    this.userList,
  });

  final bool loading;
  final List<PostModel>? postList;
  final List<UserModel>? userList;

  PostsState copyWith({
    bool? loading,
    List<PostModel>? postList,
    List<UserModel>? userList,
  }) {
    return PostsState(
      loading: loading ?? this.loading,
      postList: postList ?? this.postList,
      userList: userList ?? this.userList,
    );
  }

  @override
  List<Object?> get props => [
        loading,
        postList,
        userList,
      ];

  factory PostsState.initial() => const PostsState();
}
