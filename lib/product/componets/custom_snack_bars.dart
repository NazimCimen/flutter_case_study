import 'package:case_study/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

@immutable
class CustomSnackBars {
  const CustomSnackBars._();

  static void showCustomBottomScaffoldSnackBar({
    required BuildContext context,
    required String text,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.primaryColor,
        content: Text(text, style: Theme.of(context).textTheme.bodyLarge),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
