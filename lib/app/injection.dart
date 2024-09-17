import 'package:fudo/core/network/network_info.dart';
import 'package:fudo/core/network/network_info_impl.dart';
import 'package:fudo/data/api/auth_api_impl.dart';
import 'package:fudo/data/repositories/auth_repository_impl.dart';
import 'package:fudo/domain/api/auth_api.dart';
import 'package:fudo/domain/repositories/auth_repository.dart';
import 'package:fudo/domain/usecases/login_usecase.dart';
import 'package:fudo/presentation/views/auth/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final sl = GetIt.instance;

Future<void> injectDependencies() async {
  sl
    ..registerLazySingleton(() => InternetConnectionChecker())
    ..registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()))
    ..registerLazySingleton<AuthApi>(() => AuthApiImpl())
    ..registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(api: sl(), networkInfo: sl()))
    ..registerLazySingleton(() => LoginUsecase(sl()))
    ..registerFactory(() => AuthBloc(loginUsecase: sl()));
}
