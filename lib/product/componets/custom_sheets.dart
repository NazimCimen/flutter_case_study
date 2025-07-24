
import 'package:flutter/material.dart';

@immutable
final class CustomSheets {
  const CustomSheets._();

  static void showSheetFlexibleWithKeyboard(
    BuildContext context,
    Widget Function({double bottomPadding, double bottomInsets}) child,
  ) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        final bottomInsets = MediaQuery.of(context).viewInsets.bottom;
        final bottomPadding = MediaQuery.of(context).padding.bottom;
        return child(bottomInsets: bottomInsets, bottomPadding: bottomPadding);
      },
    );
  }
}
