import 'package:case_study/config/theme/app_colors.dart';
import 'package:case_study/core/size/app_border_radius_extensions.dart';
import 'package:case_study/core/size/constant_size.dart';
import 'package:case_study/core/utils/enum/image_enum.dart';
import 'package:flutter/material.dart';

class AuthWithOtherProvider extends StatelessWidget {
  final bool isLoading;
  final VoidCallback? onGoogleTap;
  final VoidCallback? onAppleTap;
  final VoidCallback? onFacebookTap;

  const AuthWithOtherProvider({
    this.isLoading = false,
    this.onGoogleTap,
    this.onAppleTap,
    this.onFacebookTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _ProviderButton(
          icon: ImageEnums.ic_google.toPathPng,
          onTap: onGoogleTap,
        ),
        SizedBox(width: context.cLowValue),
        _ProviderButton(icon: ImageEnums.ic_apple.toPathPng, onTap: onAppleTap),
        SizedBox(width: context.cLowValue),
        _ProviderButton(
          icon: ImageEnums.ic_facebook.toPathPng,
          onTap: onFacebookTap,
        ),
      ],
    );
  }
}

class _ProviderButton extends StatelessWidget {
  final String icon;
  final VoidCallback? onTap;
  const _ProviderButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          color: AppColors.white.withOpacity(0.1),
          borderRadius: context.cBorderRadiusAll18,
          border: Border.all(color: AppColors.white.withOpacity(0.2)),
        ),
        child: Center(child: Image.asset(icon, fit: BoxFit.contain)),
      ),
    );
  }
}
