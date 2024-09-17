part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState({
    this.loading = false,
    this.isAuthenticatedSuccess = false,
    this.isAuthenticatedFailure = false,
  });

  final bool loading;
  final bool isAuthenticatedSuccess;
  final bool isAuthenticatedFailure;

  AuthState copyWith({
    bool? loading,
    bool? isAuthenticatedSuccess,
    bool? isAuthenticatedFailure,
  }) {
    return AuthState(
      loading: loading ?? this.loading,
      isAuthenticatedSuccess: isAuthenticatedSuccess ?? this.isAuthenticatedSuccess,
      isAuthenticatedFailure: isAuthenticatedFailure ?? this.isAuthenticatedFailure,
    );
  }

  @override
  List<Object?> get props => [
        loading,
        isAuthenticatedSuccess,
        isAuthenticatedFailure,
      ];

  factory AuthState.initial() => const AuthState();
}
