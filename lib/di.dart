// ignore_for_file: depend_on_referenced_packages, unused_import

import 'dart:async';
import 'package:get_it/get_it.dart';
import 'package:http_interceptor/http/http.dart';
import 'package:http_retry/http_retry.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:yuktidea_flutter_deveoper_task/core/network/network_info.dart';
import 'package:yuktidea_flutter_deveoper_task/core/utils/shared_preference.dart';
import 'package:yuktidea_flutter_deveoper_task/features/auth/data/datasources/auth_data_source.dart';
import 'package:yuktidea_flutter_deveoper_task/features/auth/data/repositories/auth_repository.dart';
import 'package:yuktidea_flutter_deveoper_task/features/auth/presentation/bloc/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await Storage.init();

//////diooo

  // sl.registerSingleton(UserRepository(getIt.get<UserApi>()));

  //! Features - Number Trivia
//Bloc
  // sl.registerFactory(() => LocaleCubit());
  sl.registerFactory(() => AuthBloc(sl()));

//THEME bloc
  // sl.registerFactory(() => ThemeCubit());
  // sl.registerFactory(() => DrawerCubit());

  ////other features
  // categoryDi();
  // checkoutDi();
  // orderDi();

  // Use cases

// Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepository(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  // Data sources
  sl.registerLazySingleton<AuthDataSource>(
    () => AuthDataSourceImpl(client: sl()),
  );

//! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => RetryClient(sl()));
  sl.registerLazySingleton(() => http.Client());
  // sl.registerLazySingleton(() => Dio());
  // sl.registerFactory(() => DioClient());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
