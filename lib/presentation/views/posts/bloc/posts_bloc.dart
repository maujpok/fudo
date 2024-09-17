import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fudo/data/models/post_model.dart';
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
        emit(state.copyWith(
          loading: false,
          postList: posts,
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
      },
    );
  }
}
