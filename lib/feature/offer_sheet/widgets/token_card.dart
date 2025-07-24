part of '../offer_sheet.dart';

/// This widget displays a token card with a gradient background, original and total token amounts, price, and bonus.
class _TokenCard extends StatelessWidget {
  const _TokenCard({
    required this.original,
    required this.total,
    required this.price,
    required this.bonus,
    this.gradientColors = const [
      AppColors.primaryColorDark,
      AppColors.primaryColor,
    ],
  });
  final String original;
  final String total;
  final String price;
  final String bonus;
  final List<Color> gradientColors;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.cXxLargeValue * 3,
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          // Main Card Container with INNER shadow effect
          Container(
            padding: EdgeInsets.all(context.cLowValue),
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.topLeft,
                radius: 2.2,
                colors: gradientColors,
                stops: const [0.0, 1.0],
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withValues(alpha: 0.4)),
              boxShadow: [
                BoxShadow(
                  color: AppColors.white.withValues(alpha: 0.3),
                  blurRadius: 8.33,
                  blurStyle: BlurStyle.inner,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: context.cMediumValue),
                // Token amounts
                Column(
                  children: [
                    Text(
                      original,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    SizedBox(height: context.cLowValue / 2),
                    Text(
                      total,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      StringConstants.tokenLabel,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                // Price section
                Column(
                  children: [
                    Divider(
                      color: Colors.white.withValues(alpha: 0.1),
                      thickness: 1,
                    ),
                    Text(
                      price,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    Text(
                      StringConstants.perWeekLabel,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Bonus Badge (overflowing)
          Positioned(
            top: -10,
            left: 32,
            child: Align(
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(
                  horizontal: context.cLowValue,
                  vertical: context.cLowValue / 2,
                ),
                decoration: BoxDecoration(
                  color: gradientColors.first,
                  borderRadius: context.cBorderRadiusAll18,
                  border: Border.all(
                    color: AppColors.white.withValues(alpha: 0.4),
                  ),
                ),
                child: Text(
                  bonus,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
