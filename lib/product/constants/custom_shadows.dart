import 'package:case_study/core/size/constant_size.dart';
import 'package:case_study/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomShadows {
  CustomShadows._();

  static List<Shadow> customLowShadow(BuildContext context) => [
    Shadow(
      offset: const Offset(1.5, 1.5),
      blurRadius: 2,
      color: Theme.of(context).colorScheme.scrim.withOpacity(0.7),
    ),
  ];
  static Container redShadowContainer(BuildContext context) => Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(context.cLargeValue),
        topRight: Radius.circular(context.cLargeValue),
      ),
      gradient: RadialGradient(
        center: Alignment.topCenter,
        radius: 1.5,
        colors: [
          AppColors.primaryColor.withValues(alpha: 0.2),
          AppColors.primaryColor.withValues(alpha: 0.1),
          AppColors.primaryColor.withValues(alpha: 0.05),
          AppColors.primaryColor.withValues(alpha: 0.01),
        ],
        stops: const [0.4, 0.5, 0.6, 0.7],
      ),
    ),
  );
}
