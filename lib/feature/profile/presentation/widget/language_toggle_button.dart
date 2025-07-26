import 'package:case_study/config/theme/app_colors.dart';
import 'package:case_study/config/localization/locale_constants.dart';
import 'package:case_study/core/utils/enum/image_enum.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

/// Language toggle button widget for switching between Turkish and English
class LanguageToggleButton extends StatelessWidget {
  const LanguageToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Toggle between Turkish and English
        final currentLocale = context.locale;
        if (currentLocale.languageCode ==
            LocaleConstants.trLocale.languageCode) {
          context.setLocale(LocaleConstants.enLocale);
        } else {
          context.setLocale(LocaleConstants.trLocale);
        }
      },
      child: Container(
        width: 30,
        height: 24,
        decoration: BoxDecoration(
          color: AppColors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.white.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: Center(
          child: Image.asset(
            context.locale.languageCode ==
                    LocaleConstants.trLocale.languageCode
                ? ImageEnums.flag_en.toPathPng
                : ImageEnums.flag_turkiye.toPathPng,
            width: 24,
            height: 16,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
} 