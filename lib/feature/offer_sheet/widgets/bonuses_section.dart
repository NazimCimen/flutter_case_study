part of '../offer_sheet.dart';

/// This widget displays the bonuses section with a title and a list of bonus items.
class _BonusesSection extends StatelessWidget {
  const _BonusesSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.cMediumValue),
      decoration: BoxDecoration(
        borderRadius: context.cBorderRadiusAll18,
        border: Border.all(color: AppColors.white.withValues(alpha: 0.1)),
        gradient: RadialGradient(
          colors: [
            AppColors.white.withValues(alpha: 0.1),
            AppColors.white.withValues(alpha: 0.03),
          ],
          stops: const [0.0, 1.0],
        ),
      ),
      child: Column(
        children: [
          Text(
            StringConstants.bonusesSectionTitle,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: context.cMediumValue),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _BonusItem(icon: ImageEnums.ic_sheet1, label: StringConstants.bonusPremiumAccount),
              _BonusItem(icon: ImageEnums.ic_sheet2, label: StringConstants.bonusMoreMatches),
              _BonusItem(icon: ImageEnums.ic_sheet3, label: StringConstants.bonusHighlight),
              _BonusItem(icon: ImageEnums.ic_sheet4, label: StringConstants.bonusMoreLikes),
            ],
          ),
        ],
      ),
    );
  }
} 