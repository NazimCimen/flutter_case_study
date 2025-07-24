part of '../offer_sheet.dart';

/// This widget displays the token packages section with a title and a list of token cards.
class _TokenPackages extends StatelessWidget {
  const _TokenPackages();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: context.cMediumValue),

        Text(
          StringConstants.selectTokenPackage,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: context.cLargeValue),
        Row(
          children: [
            const Expanded(
              child: _TokenCard(
                original: '200',
                total: '330',
                price: '₺99,99',
                bonus: '+10%',
              ),
            ),
            SizedBox(width: context.cMediumValue),
            const Expanded(
              child: _TokenCard(
                original: '2000',
                total: '3375',
                price: '₺799,99',
                bonus: '+70%',
                gradientColors: [AppColors.purple, AppColors.primaryColor],
              ),
            ),
            SizedBox(width: context.cMediumValue),
            const Expanded(
              child: _TokenCard(
                original: '1000',
                total: '1350',
                price: '₺399,99',
                bonus: '+35%',
              ),
            ),
          ],
        ),
        SizedBox(height: context.cMediumValue),
      ],
    );
  }
} 