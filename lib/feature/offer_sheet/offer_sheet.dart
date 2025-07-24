import 'dart:ui';
import 'package:case_study/config/theme/app_colors.dart';
import 'package:case_study/core/size/app_border_radius_extensions.dart';
import 'package:case_study/core/size/constant_size.dart';
import 'package:case_study/product/widgets/custom_button.dart';
import 'package:case_study/product/constants/custom_shadows.dart';
import 'package:flutter/material.dart';
import 'package:case_study/core/utils/enum/image_enum.dart';
part 'widgets/bonus_item.dart';
part 'widgets/header.dart';
part 'widgets/bonuses_section.dart';
part 'widgets/token_packages.dart';
part 'widgets/token_card.dart';

class OfferSheet extends StatelessWidget {
  const OfferSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Stack(
        children: [
          // Red shadow background
          Positioned.fill(
            child: CustomShadows.redShadowContainer(context),
          ),
          
          // Main content
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(context.cLargeValue),
                topRight: Radius.circular(context.cLargeValue),
              ),
            ),
            child: IntrinsicHeight(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Handle bar
                  Container(
                    margin: EdgeInsets.only(top: context.cMediumValue),
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[600],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),

                  // Content
                  Flexible(
                    child: SingleChildScrollView(
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
                              text: 'Tüm Jetonları Gör',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}
