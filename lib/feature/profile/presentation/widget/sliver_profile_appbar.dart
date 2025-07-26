import 'package:case_study/config/localization/string_constants.dart';
import 'package:case_study/config/theme/app_colors.dart';
import 'package:case_study/core/size/constant_size.dart';
import 'package:case_study/core/size/padding_extension.dart';
import 'package:case_study/core/utils/enum/image_enum.dart';
import 'package:case_study/feature/navbar/viewmodel/navbar_view_model.dart';
import 'package:case_study/feature/offer_sheet/offer_sheet.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:case_study/config/localization/locale_constants.dart';
import 'language_toggle_button.dart';

/// Sliver App Bar for profile view with flexible space and better UX
class SliverProfileAppBar extends StatelessWidget {
  const SliverProfileAppBar({super.key, this.isOffer = false});
  final bool isOffer;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      scrolledUnderElevation: 0,
      leading: IconButton(
        padding: EdgeInsets.zero,
        style: IconButton.styleFrom(
          padding: context.cPaddingSmall * 1.5,
          backgroundColor: AppColors.white.withValues(alpha: 0.1),
          shape: CircleBorder(
            side: BorderSide(
              color: AppColors.white.withValues(alpha: 0.2),
              width: 2,
            ),
          ),
        ),
        onPressed: () {
          if (isOffer) {
            context.read<NavBarCubit>().setTabIndex(0);
          } else {
            Navigator.pop(context);
          }
        },
        icon: Icon(Icons.arrow_back, size: context.cLargeValue),
      ),
      title: Row(
        children: [
          // Title
          Expanded(
            child: Text(
              StringConstants.profileDetailTitle,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),

      actions: [
        // Language flag button
        const LanguageToggleButton(),
        SizedBox(width: context.cLowValue/2),
        //offer button
        if (isOffer)
          GestureDetector(
            onTap: () {
              showModalBottomSheet<void>(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                barrierColor: AppColors.black.withValues(alpha: 0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(context.cLargeValue),
                  ),
                ),
                builder: (context) => const OfferSheet(),
              );
            },
            child: Container(
              width: 112,
              height: 33,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(53),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(ImageEnums.ic_offer.toPathPng, fit: BoxFit.cover),
                  SizedBox(width: context.cLowValue / 2),
                  Text(
                    StringConstants.limitedOffer,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
