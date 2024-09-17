import 'package:equatable/equatable.dart';

class ServerException implements Exception {}

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

class ServerFailure extends Failure {}

class NetworkFailure extends Failure {}

class AuthFailure extends Failure {}

class BadRequestFailure extends Failure {}

enum FailureType {
  server,
  network,
  auth,
  badRequest,
}

FailureType getFailureType(Failure failure) {
  if (failure is ServerFailure) {
    return FailureType.server;
  } else if (failure is NetworkFailure) {
    return FailureType.network;
  } else if (failure is AuthFailure) {
    return FailureType.auth;
  } else if (failure is BadRequestFailure) {
    return FailureType.badRequest;
  } else {
    return FailureType.server;
  }
}

const Map<FailureType, String> failureMessages = {
  FailureType.server: 'Server Failure',
  FailureType.network: 'No internet connection',
  FailureType.auth: 'Invalid email or password',
  FailureType.badRequest: 'An error ocurred. Check your request and try again',
};

String getFailureMessage(FailureType type) {
  return failureMessages[type] ?? 'An error ocurred. Try again';
}
