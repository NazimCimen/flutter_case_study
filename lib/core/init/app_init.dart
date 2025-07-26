import 'package:easy_localization/easy_localization.dart';
import 'package:case_study/di/di_container.dart';
import 'package:flutter/material.dart';
import 'package:case_study/main.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:case_study/config/localization/locale_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:case_study/feature/auth/presentation/viewmodel/auth_cubit.dart';
import 'package:case_study/feature/auth/domain/usecase/login_usecase.dart';
import 'package:case_study/feature/auth/domain/usecase/signup_usecase.dart';
import 'package:case_study/feature/home/presentation/cubit/home_cubit.dart';
import 'package:case_study/feature/home/domain/usecase/get_movie_list_usecase.dart';
import 'package:case_study/core/cache/cache_enum.dart';
import 'package:case_study/feature/navbar/viewmodel/navbar_view_model.dart';
import 'package:case_study/feature/shared/state/user_cubit.dart';
import 'package:case_study/feature/profile/presentation/cubit/profile_cubit.dart';
import 'package:case_study/feature/profile/domain/usecase/update_profile_image_usecase.dart';
import 'package:case_study/feature/home/domain/usecase/toggle_favorite_usecase.dart';
import 'package:case_study/feature/profile/domain/usecase/get_favorite_movies_usecase.dart';

abstract class AppInit {
  Future<void> initialize();
  Future<void> run();
  Widget getApp();
}

class AppInitImpl extends AppInit {
  @override
  Widget getApp() {
    return EasyLocalization(
      supportedLocales: const [
        LocaleConstants.enLocale,
        LocaleConstants.trLocale,
      ],
      path: LocaleConstants.localePath,
      fallbackLocale: LocaleConstants.enLocale,

      child: MultiBlocProvider(
        providers: [
          // Auth Cubit - Global auth state management
          BlocProvider<AuthCubit>(
            create: (context) => AuthCubit(
              loginUseCase: getIt<LoginUseCase>(),
              signupUseCase: getIt<SignupUseCase>(),
              userCubit: getIt<UserCubit>(),
            ),
          ),
          // Home Cubit - Global home state management
          BlocProvider<HomeCubit>(
            create: (context) => HomeCubit(
              getMovieListUseCase: getIt<GetMovieListUseCase>(),
              toggleFavoriteUseCase: getIt<ToggleFavoriteUseCase>(),
            ),
          ),
          // Main Layout Cubit - Global main layout state management
          BlocProvider<NavBarCubit>(create: (context) => NavBarCubit()),

          // User Cubit - Global user state management
          BlocProvider<UserCubit>(create: (context) => getIt<UserCubit>()),

          // Profile Cubit - Global profile state management
          BlocProvider<ProfileCubit>(
            create: (context) => ProfileCubit(
              userCubit: getIt<UserCubit>(),
              updateProfileImageUseCase: getIt<UpdateProfileImageUseCase>(),
              getFavoriteMoviesUseCase: getIt<GetFavoriteMoviesUseCase>(),
            ),
          ),
        ],
        child: const MyApp(),
      ),
    );
  }

  @override
  Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    await EasyLocalization.ensureInitialized();
    await Hive.initFlutter();

    // Initialize Hive boxes
    await _initializeHiveBoxes();

    setupDI();
  }

  /// Initialize Hive boxes for cache management
  Future<void> _initializeHiveBoxes() async {
    // Open secure storage box for encrypted data
    await Hive.openBox<String>(CacheHiveBoxEnum.secureStorage.name);
  }

  @override
  Future<void> run() async {
    await initialize();
    runApp(getApp());
  }
}
