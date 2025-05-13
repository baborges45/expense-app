import 'package:expense_app/app/commons/commons.dart';
import 'package:flutter/material.dart';

class TopCard extends StatelessWidget with ThemeInjector {
  final String balance;
  final String expense;
  final String income;

  const TopCard({
    required this.balance,
    required this.expense,
    required this.income,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Color positiveColor = aliasTokens.color.positive.placeholderColor;
    Color negativeColor = aliasTokens.color.elements.negativeColor;

    return SafeArea(
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.9,
        height: 200,
        decoration: BoxDecoration(
          color: aliasTokens.color.elements.bgColor02,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: aliasTokens.color.elements.bgColor03.withValues(alpha: globalTokens.shapes.opacity.superLow),
              blurRadius: globalTokens.shapes.border.widthSm,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          spacing: 15,
          children: [
            SizedBox(
              height: 20,
            ),
            ExpenseHeading(
              'Saldo disponível',
              size: ExpenseHeadingSize.xs,
            ),
            ExpenseCurrency(
              price: double.parse(balance),
              size: ExpenseCurrencySize.lg,
              type: ExpenseCurrencyType.currency,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildIncome(positiveColor, context),
                _buildExpense(negativeColor, context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpense(Color color, BuildContext context) => Container(
        width: MediaQuery.sizeOf(context).width * 0.4,
        // decoration: BoxDecoration(
        //   color: aliasTokens.color.elements.bgColor02,
        //   borderRadius: BorderRadius.circular(10),
        //   border: Border.all(
        //     color: aliasTokens.color.elements.negativeColor,
        //     width: 1,
        //   ),
        // ),
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spacing.s1x,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: spacing.s1x,
              children: [
                CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.white,
                  child: ExpenseIcon(
                    icon: ExpenseIcons.downLine,
                    color: color,
                    size: ExpenseIconSize.sm,
                  ),
                ),
                ExpenseHeading(
                  'Despesa',
                  size: ExpenseHeadingSize.xs,
                ),
              ],
            ),
            ExpenseCurrency(
              price: double.parse(expense),
              size: ExpenseCurrencySize.sm,
              type: ExpenseCurrencyType.outcome,
            ),
          ],
        ),
      );

  Widget _buildIncome(Color color, BuildContext context) => Container(
        width: MediaQuery.sizeOf(context).width * 0.4,
        // decoration: BoxDecoration(
        //   color: aliasTokens.color.elements.bgColor02,
        //   borderRadius: BorderRadius.circular(10),
        //   border: Border.all(
        //     color: color,
        //     width: 1,
        //   ),
        // ),
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spacing.s1x,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: spacing.s1x,
              children: [
                CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.white,
                  child: ExpenseIcon(
                    icon: ExpenseIcons.upLine,
                    color: color,
                    size: ExpenseIconSize.sm,
                  ),
                ),
                ExpenseHeading(
                  'Renda',
                  size: ExpenseHeadingSize.xs,
                ),
              ],
            ),
            ExpenseCurrency(
              price: double.parse(income),
              size: ExpenseCurrencySize.sm,
              type: ExpenseCurrencyType.income,
            ),
          ],
        ),
      );
}
