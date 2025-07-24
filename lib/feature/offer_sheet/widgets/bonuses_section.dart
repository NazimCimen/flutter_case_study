part of '../offer_sheet.dart';

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
            'Alacağınız Bonuslar',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: context.cMediumValue),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _BonusItem(icon: ImageEnums.ic_sheet1, label: 'Premium\nHesap'),
              _BonusItem(
                icon: ImageEnums.ic_sheet2,
                label: 'Daha Fazla\nEşleşme',
              ),
              _BonusItem(icon: ImageEnums.ic_sheet3, label: 'Öne\nÇıkarma'),
              _BonusItem(
                icon: ImageEnums.ic_sheet4,
                label: 'Daha Fazla\nBeğeni',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
