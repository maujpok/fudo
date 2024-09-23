import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fudo/domain/usecases/login_usecase.dart';
import 'package:fudo/presentation/utils/toast_handler.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUsecase loginUsecase;

  AuthBloc({
    required this.loginUsecase,
  }) : super(AuthState.initial()) {
    on<LoginEvent>(_onLoginEvent);
  }

  FutureOr<void> _onLoginEvent(
    LoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(
      loading: true,
      isAuthenticatedFailure: false,
      isAuthenticatedSuccess: false,
    ));

    final response = await loginUsecase(LoginParams(email: event.email, password: event.password));
    response.fold(
      (failure) {
        emit(state.copyWith(loading: false));
        ToastHandler.handleErrorToast(failure);
      },
      (success) => emit(state.copyWith(loading: false, isAuthenticatedSuccess: true)),
    );
  }
}
