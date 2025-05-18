import 'package:expense_app/app/commons/commons.dart';
import 'package:flutter/material.dart';

class SettingsTemWidget extends StatelessWidget with ThemeInjector {
  final String label;
  final VoidCallback onPressed;

  const SettingsTemWidget({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: ExpenseListContentLine(
        label: label,
        trailingButton: ExpenseButtonIcon(
          icon: ExpenseIcons.navigationRightLine,
          onPressed: onPressed,
        ),
      ),
    );
  }
}
