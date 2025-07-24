import 'package:case_study/config/theme/app_colors.dart';
import 'package:case_study/core/size/app_border_radius_extensions.dart';
import 'package:flutter/material.dart';

class CustomInputDecoration {
  CustomInputDecoration._();
  static InputDecoration inputAuthDecoration({
    required BuildContext context,
    required String hintText,
    required String prefixIconPath,
    bool? isPassword,
    VoidCallback? changeObsecureText,
    bool? obsecureText,
  }) => InputDecoration(
    fillColor: AppColors.white.withOpacity(0.1),
    filled: true,
    prefixIcon: Image.asset(
      prefixIconPath,
      color: AppColors.white.withOpacity(0.5),
    ),
    hintText: hintText,
    hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
      fontWeight: FontWeight.w400,
      color: AppColors.white.withOpacity(0.5),
      fontSize: 12,
    ),
    border: OutlineInputBorder(
      borderRadius: context.cBorderRadiusAll18,
      borderSide: BorderSide(color: AppColors.white.withOpacity(0.2)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: context.cBorderRadiusAll18,
      borderSide: BorderSide(color: AppColors.white.withOpacity(0.2)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: context.cBorderRadiusAll18,
      borderSide: const BorderSide(color: AppColors.primaryColor),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: context.cBorderRadiusAll18,
      borderSide: const BorderSide(color: Colors.red),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: context.cBorderRadiusAll18,
      borderSide: const BorderSide(color: Colors.red),
    ),
    suffixIcon: isPassword ?? false
        ? IconButton(
            onPressed: changeObsecureText,
            icon: Icon(
              obsecureText ?? false ? Icons.visibility_off : Icons.visibility,
              color: AppColors.white.withOpacity(0.5),
            ),
          )
        : null,
  );
}
