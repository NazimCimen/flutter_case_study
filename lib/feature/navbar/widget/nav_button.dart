part of '../view/navbar_view.dart';

class _NavButton extends StatelessWidget {
  const _NavButton({
    required this.icon,
    required this.labelKey,
    required this.onTap,
    required this.isSelected,
  });

  final String icon;
  final String labelKey;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: context.cLowValue),
        padding: EdgeInsets.symmetric(
          horizontal: context.cLargeValue,
          vertical: context.cLowValue * 3 / 4,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? AppColors.white
                : AppColors.white.withValues(alpha: 0.2),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              icon,
              width: context.cLargeValue,
              height: context.cLargeValue,
              color: isSelected
                  ? AppColors.white
                  : AppColors.white.withValues(alpha: 0.7),
            ),
            SizedBox(width: context.cLowValue),
            Text(
              labelKey.tr(),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: context.cLowValue * 1.5,
                color: isSelected
                    ? AppColors.white
                    : AppColors.white.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
