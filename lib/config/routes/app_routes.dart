import 'package:case_study/feature/auth/presentation/view/login_view.dart';
import 'package:case_study/feature/auth/presentation/view/sign_up_view.dart';
import 'package:case_study/feature/home/presentation/view/home_view.dart';
import 'package:case_study/feature/navbar/view/navbar_view.dart';
import 'package:case_study/feature/profile/presentation/view/profile_detail_view.dart';
import 'package:case_study/feature/splash/presentation/splash_view.dart';
import 'package:flutter/material.dart';

final class AppRoutes {
  const AppRoutes._();
  static const String splashView = '/splashView';
  static const String initialRoute = '/initialRoute';
  static const String loginView = '/loginView';
  static const String signupView = '/signupView';
  static const String navBarView = '/navBarView';
  static const String homeView = '/homeView';
  static const String profileDetailView = '/profileDetailView';

  static Map<String, WidgetBuilder> get routes => {
    splashView: (context) => const SplashView(),
    initialRoute: (context) => const SplashView(),
    loginView: (context) => const LoginView(),
    homeView: (context) => const HomeView(),
    signupView: (context) => const SignUpView(),
    navBarView: (context) => const NavBarView(),
    profileDetailView: (context) => const ProfileDetailView(),
  };
}
