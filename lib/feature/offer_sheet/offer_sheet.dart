import 'dart:ui';
import 'package:case_study/config/theme/app_colors.dart';
import 'package:case_study/core/size/app_border_radius_extensions.dart';
import 'package:case_study/core/size/constant_size.dart';
import 'package:case_study/product/widgets/custom_button.dart';
import 'package:case_study/product/constants/custom_shadows.dart';
import 'package:flutter/material.dart';
import 'package:case_study/core/utils/enum/image_enum.dart';
import 'package:case_study/config/localization/string_constants.dart';
part 'widgets/bonus_item.dart';
part 'widgets/header.dart';
part 'widgets/bonuses_section.dart';
part 'widgets/token_packages.dart';
part 'widgets/token_card.dart';

// This widget displays the offer sheet with a header, bonuses section, token packages, and a call to action button.
final class OfferSheet extends StatelessWidget {
  const OfferSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(context.cLargeValue),
              topRight: Radius.circular(context.cLargeValue),
            ),
          ),
          child: IntrinsicHeight(
            child: Flexible(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: CustomShadows.redShadowContainer(context),
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.cMediumValue,
                      ),
                      child: Column(
                        children: [
                          // Title and Subtitle
                          const _Header(),

                          // Bonuses Section
                          const _BonusesSection(),

                          // Token Packages
                          const _TokenPackages(),

                          // Call to Action Button
                          CustomButtonWidget(
                            onPressed: () {},
                            text: StringConstants.seeAllTokens,
                          ),
                          SizedBox(height: context.cLowValue),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
} 