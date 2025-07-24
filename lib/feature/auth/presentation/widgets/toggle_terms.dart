part of '../view/sign_up_view.dart';

class _ToggleTerms extends StatelessWidget {
  const _ToggleTerms();

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: 'Kullanıcı sözleşmesini ',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w400,
          color: AppColors.white.withOpacity(0.5),
          fontSize: 12,
        ),
        children: [
          TextSpan(
            text: 'okudum ve kabul ediyorum.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w400,
              decoration: TextDecoration.underline,
              fontSize: 12,
            ),
            recognizer: TapGestureRecognizer()..onTap = () {},
          ),
          TextSpan(
            text: ' Bu sözleşmeyi okuyarak devam ediniz lütfen.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w400,
              color: AppColors.white.withOpacity(0.5),
              fontSize: 12,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.left,
    );
  }
}
