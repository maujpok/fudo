part of 'posts_bloc.dart';

class PostsState extends Equatable {
  const PostsState({
    this.loading = false,
    this.postList,
  });

  final bool loading;
  final List<PostModel>? postList;

  PostsState copyWith({
    bool? loading,
    List<PostModel>? postList,
  }) {
    return PostsState(
      loading: loading ?? this.loading,
      postList: postList ?? this.postList,
    );
  }

  @override
  List<Object?> get props => [
        loading,
        postList,
      ];

  factory PostsState.initial() => const PostsState();
}
