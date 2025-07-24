import 'package:case_study/feature/auth/domain/repository/auth_repository.dart';
import 'package:case_study/feature/auth/domain/usecase/login_usecase.dart';
import 'package:case_study/feature/auth/domain/usecase/signup_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:case_study/core/connection/network_info.dart';
import 'package:case_study/feature/auth/data/datasource/auth_remote_data_source.dart';
import 'package:case_study/feature/auth/data/repository/auth_repository_impl.dart';
import 'package:case_study/feature/auth/presentation/viewmodel/auth_cubit.dart';
import 'package:case_study/feature/home/data/data_source/home_remote_data_source.dart';
import 'package:case_study/feature/home/domain/repository/home_repository.dart';
import 'package:case_study/feature/home/data/repository/home_repository_impl.dart';
import 'package:case_study/feature/home/domain/usecase/get_movie_list_usecase.dart';
import 'package:case_study/feature/home/presentation/cubit/home_cubit.dart';
import 'package:case_study/feature/navbar/viewmodel/navbar_view_model.dart';
import 'package:case_study/core/services/token_services.dart';
import 'package:case_study/core/state/user_cubit.dart';
import 'package:case_study/feature/profile/presentation/cubit/profile_cubit.dart';

final getIt = GetIt.instance;

void setupDI() {
  // Core/Shared Services
  getIt
    ..registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker(),
    )
    ..registerLazySingleton<INetworkInfo>(
      () => NetworkInfo(getIt<InternetConnectionChecker>()),
    )
    ..registerLazySingleton<Dio>(() => Dio())
    // Token Service - Global token management
    ..registerLazySingleton<TokenService>(() => TokenServiceImpl())
    // User Cubit - Global user state management
    ..registerLazySingleton<UserCubit>(() => UserCubit())
    // Auth Feature Dependencies
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(dio: getIt<Dio>()),
    )
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        remoteDataSource: getIt<AuthRemoteDataSource>(),
        networkInfo: getIt<INetworkInfo>(),
        tokenService: getIt<TokenService>(),
      ),
    )
    ..registerLazySingleton<SignupUseCase>(
      () => SignupUseCase(repository: getIt<AuthRepository>()),
    )
    ..registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(repository: getIt<AuthRepository>()),
    )
    ..registerFactory<AuthCubit>(
      () => AuthCubit(
        signupUseCase: getIt<SignupUseCase>(),
        loginUseCase: getIt<LoginUseCase>(),
        userCubit: getIt<UserCubit>(),
      ),
    )
    // Home Feature Dependencies
    ..registerLazySingleton<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(
        dio: getIt<Dio>(),
        tokenService: getIt<TokenService>(),
      ),
    )
    ..registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(
        networkInfo: getIt<INetworkInfo>(),
        remoteDataSource: getIt<HomeRemoteDataSource>(),
      ),
    )
    ..registerLazySingleton<GetMovieListUseCase>(
      () => GetMovieListUseCase(repository: getIt<HomeRepository>()),
    )
    ..registerFactory<HomeCubit>(
      () => HomeCubit(getMovieListUseCase: getIt<GetMovieListUseCase>()),
    )
    // Navbar Feature Dependencies
    ..registerFactory<NavBarCubit>(
      () => NavBarCubit(),
    )
    // Profile Feature Dependencies
    ..registerFactory<ProfileCubit>(
      () => ProfileCubit(userCubit: getIt<UserCubit>()),
    );
}
