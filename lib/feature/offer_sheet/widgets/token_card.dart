part of '../offer_sheet.dart';

class _TokenCard extends StatelessWidget {
  const _TokenCard({
    required this.original,
    required this.total,
    required this.price,
    required this.bonus,
  });
  final String original;
  final String total;
  final String price;
  final String bonus;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          // Main Card Container with INNER shadow effect
          Container(
            padding: EdgeInsets.all(context.cLowValue),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF6F060B), Color(0xFFE50914)],
                stops: [0.0, 1.0],
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withValues(alpha: 0.4)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 20), // Space for badge
                // Token amounts
                Column(
                  children: [
                    Text(
                      original.toString(),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    SizedBox(height: context.cLowValue / 2),
                    Text(
                      total.toString(),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      'Jeton',
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
                      ),
                    ),
                    Text(
                      'Başına haftalık',
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
                  color: const Color(0xFF6F060B),
                  borderRadius: context.cBorderRadiusAll18,
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.4),
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
