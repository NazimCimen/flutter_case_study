import 'package:case_study/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:case_study/config/theme/custom_color_sheme.dart';

abstract class ApplicationTheme {
  ThemeData get themeData;
  ColorScheme get colorScheme;
}

/// Custom light theme for project design
final class CustomLightTheme implements ApplicationTheme {
  @override
  ColorScheme get colorScheme => CustomColorScheme.lightScheme;
  @override
  ThemeData get themeData => ThemeData();
}

/// Custom Dark theme for project design
final class CustomDarkTheme implements ApplicationTheme {
  @override
  ColorScheme get colorScheme => CustomColorScheme.darkScheme;
  @override
  ThemeData get themeData => ThemeData(
    useMaterial3: true,
    colorScheme: CustomColorScheme.darkScheme,
    fontFamily: 'EuclidCircularA',
    scaffoldBackgroundColor: AppColors.background,
    sliderTheme: SliderThemeData(
      activeTrackColor: colorScheme.primary,
      inactiveTrackColor: Colors.grey.shade300,
      thumbColor: colorScheme.primary,
      overlayColor: colorScheme.primary.withOpacity(0.2),
      trackHeight: 4,
      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
      overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
    ),
    appBarTheme: const AppBarTheme(backgroundColor: AppColors.background),
  );
}
