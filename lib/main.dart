import 'package:easy_localization/easy_localization.dart';
import 'package:case_study/config/localization/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:case_study/config/routes/app_routes.dart';
import 'package:case_study/config/routes/navigator_service.dart';
import 'package:case_study/core/init/app_init.dart';
import 'package:case_study/config/theme/application_theme.dart';

void main() async {
  final appInit = AppInitImpl();
  await appInit.run();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: CustomDarkTheme().themeData,
      themeMode: ThemeMode.dark,
      title: StringConstants.appName,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      navigatorKey: NavigatorService.navigatorKey,
      routes: AppRoutes.routes,
      initialRoute: AppRoutes.initialRoute,
    );
  }
}
