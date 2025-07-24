import 'package:case_study/config/routes/app_routes.dart';
import 'package:case_study/config/routes/navigator_service.dart';
import 'package:case_study/core/services/token_services.dart';
import 'package:case_study/di/di_container.dart';
import 'package:case_study/feature/splash/presentation/splash_view.dart';
import 'package:flutter/material.dart';

mixin SplashMixin on State<SplashView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future<void>.delayed(const Duration(seconds: 2));
      await _initializeApp();
    });
  }

  /// Initialize app and check authentication status
  Future<void> _initializeApp() async {
    if (!mounted) return;
    await _checkAuthenticationStatus();
  }

  /// Check if user is authenticated and navigate accordingly
  Future<void> _checkAuthenticationStatus() async {
    final tokenService = getIt<TokenService>();
    final tokenResult = await tokenService.getToken();

    if (!mounted) return;
    tokenResult.fold(
      (fail) {
        NavigatorService.pushNamedAndRemoveUntil(AppRoutes.loginView);
      },
      (token) {
        if (token == null || token.isEmpty) {
          NavigatorService.pushNamedAndRemoveUntil(AppRoutes.loginView);
        } else {
          /// NavigatorService.pushNamedAndRemoveUntil(AppRoutes.navBarView);
          NavigatorService.pushNamedAndRemoveUntil(AppRoutes.navBarView);
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
