part of '../offer_sheet.dart';

// This widget displays a single bonus item with an icon and a label.
final class _BonusItem extends StatelessWidget {
  const _BonusItem({required this.icon, required this.label});
  final ImageEnums icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Stack(
            children: [
              Image.asset(
                ImageEnums.bg_sheet_icon.toPathPng,
                width: context.cLargeValue * 2.5,
                height: context.cLargeValue * 2.5,
                fit: BoxFit.cover,
              ),
              Positioned.fill(
                child: Center(
                  child: Image.asset(
                    icon.toPathPng,
                    width: context.cLargeValue,
                    height: context.cLargeValue,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: context.cLowValue),
          Text(
            label,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
