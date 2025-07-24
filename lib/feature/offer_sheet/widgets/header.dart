part of '../offer_sheet.dart';

/// This widget displays the header section with a title and a subtitle.
class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.cLargeValue*2),
      child: Column(
        children: [
          SizedBox(height: context.cLargeValue),
          Text(
            StringConstants.offerSheetHeaderTitle,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: context.cLowValue),
          Text(
            StringConstants.offerSheetHeaderSubtitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: context.cMediumValue),
        ],
      ),
    );
  }
} 