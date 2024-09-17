part of 'posts_bloc.dart';

class PostsState extends Equatable {
  const PostsState({
    this.loading = false,
    this.postListMemory,
    this.postListFiltered,
    this.userList,
  });

  final bool loading;
  final List<PostModel>? postListMemory;
  final List<PostModel>? postListFiltered;
  final List<UserModel>? userList;

  PostsState copyWith({
    bool? loading,
    List<PostModel>? postListMemory,
    List<PostModel>? postListFiltered,
    List<UserModel>? userList,
  }) {
    return PostsState(
      loading: loading ?? this.loading,
      postListMemory: postListMemory ?? this.postListMemory,
      postListFiltered: postListFiltered ?? this.postListFiltered,
      userList: userList ?? this.userList,
    );
  }

  @override
  List<Object?> get props => [
        loading,
        postListMemory,
        postListFiltered,
        userList,
      ];

  String getUserNameById(int id) => userList?.firstWhere((element) => element.id == id).name ?? '';

  factory PostsState.initial() => const PostsState();
}
