part of '../offer_sheet.dart';

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
            'Sınırlı Teklif',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: context.cLowValue),
          Text(
            'Jeton paketin\'ni seçerek bonus kazanın ve yeni bölümlerin kilidini açın!',
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