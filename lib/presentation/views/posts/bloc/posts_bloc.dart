import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fudo/data/models/_models.dart';
import 'package:fudo/domain/repositories/post_repository.dart';
import 'package:fudo/presentation/utils/toast_handler.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final PostRepository _postRepository;

  PostsBloc({required PostRepository postRepository})
      : _postRepository = postRepository,
        super(PostsState.initial()) {
    on<GetPostsEvent>(_onGetPostsEvent);
    on<CreatePostEvent>(_onCreatePostEvent);
    on<GetUsersEvent>(_onGetUsersEvent);
    on<FilterPostsByUserNameEvent>(_onFilterPostsByUserNameEvent);
    on<ResetPostsSearchEvent>(_onResetPostsSearchEvent);
  }
  FutureOr<void> _onGetPostsEvent(
    GetPostsEvent event,
    Emitter<PostsState> emit,
  ) async {
    emit(state.copyWith(loading: true));
    final posts = await _postRepository.getPosts();
    posts.fold(
      (failure) {
        emit(state.copyWith(loading: false));
        ToastHandler.handleErrorToast(failure);
      },
      (posts) {
        emit(
          state.copyWith(
            loading: false,
            postListMemory: posts,
            postListFiltered: posts,
          ),
        );
        if (state.userList == null) {
          add(GetUsersEvent());
        }
      },
    );
  }

  FutureOr<void> _onGetUsersEvent(
    GetUsersEvent event,
    Emitter<PostsState> emit,
  ) async {
    emit(state.copyWith(loading: true));
    final users = await _postRepository.getUsers();

    users.fold(
      (failure) {
        emit(state.copyWith(loading: false));
        ToastHandler.handleErrorToast(failure);
      },
      (users) {
        emit(state.copyWith(
          loading: false,
          userList: users,
        ));
      },
    );
  }

  FutureOr<void> _onCreatePostEvent(
    CreatePostEvent event,
    Emitter<PostsState> emit,
  ) async {
    emit(state.copyWith(loading: true));
    final response = await _postRepository.createPost(
      title: event.title,
      body: event.body,
      userId: event.userId,
    );
    response.fold(
      (failure) {
        emit(state.copyWith(loading: false));
        ToastHandler.handleErrorToast(failure);
      },
      (success) {
        emit(state.copyWith(loading: false));
        ToastHandler.showSuccessToast('Post created successfully');
        event.onPostCreated.call();
      },
    );
  }

  FutureOr<void> _onFilterPostsByUserNameEvent(
    FilterPostsByUserNameEvent event,
    Emitter<PostsState> emit,
  ) {
    final findUsers = state.userList?.where((user) => (user.name ?? '').toLowerCase().contains(event.query.toLowerCase())).toList();

    if (findUsers == null || findUsers.isEmpty) {
      emit(state.copyWith(postListFiltered: []));
    } else {
      final deepList = [...state.postListMemory ?? <PostModel>[]];
      emit(state.copyWith(
        postListFiltered: deepList.where((post) => findUsers.map((user) => user.id).contains(post.userId)).toList(),
      ));
    }
  }

  FutureOr<void> _onResetPostsSearchEvent(
    ResetPostsSearchEvent event,
    Emitter<PostsState> emit,
  ) {
    emit(state.copyWith(postListFiltered: [...state.postListMemory ?? []]));
  }
}
