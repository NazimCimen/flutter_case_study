part of '../offer_sheet.dart';

class _TokenPackages extends StatelessWidget {
  const _TokenPackages();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: context.cMediumValue),

        Text(
          'Kilidi açmak için bir jeton paketi seçin',
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
                //  color: Colors.red,
              ),
            ),
            SizedBox(width: context.cMediumValue),
            const Expanded(
              child: _TokenCard(
                original: '2000',
                total: '3375',
                price: '₺799,99',
                bonus: '+70%',
                //  color: Colors.purple,
              ),
            ),
            SizedBox(width: context.cMediumValue),
            const Expanded(
              child: _TokenCard(
                original: '1000',
                total: '1350',
                price: '₺399,99',
                bonus: '+35%',
                // color: Colors.red,
              ),
            ),
          ],
        ),
        SizedBox(height: context.cMediumValue),
      ],
    );
  }
}
