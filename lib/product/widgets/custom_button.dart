import 'package:case_study/core/size/app_border_radius_extensions.dart';
import 'package:case_study/core/size/constant_size.dart';
import 'package:case_study/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool isRequestAvaliable;
  const CustomButtonWidget({
    required this.onPressed,
    required this.text,
    this.isRequestAvaliable = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          padding: EdgeInsets.symmetric(vertical: context.cMediumValue * 0.95),
          shape: RoundedRectangleBorder(
            borderRadius: context.cBorderRadiusAll18,
          ),
        ),
        onPressed: onPressed,
        child: isRequestAvaliable
            ? const CircularProgressIndicator.adaptive(
                backgroundColor: AppColors.white,
                valueColor: AlwaysStoppedAnimation(AppColors.primaryColor),
              )
            : Text(
                text,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
      ),
    );
  }
}
