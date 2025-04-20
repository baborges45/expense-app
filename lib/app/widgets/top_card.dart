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

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          spacing: 15,
          children: [
            SizedBox(
              height: 40,
            ),
            ExpenseHeading(
              'Saldo disponível',
              size: ExpenseHeadingSize.xs,
            ),
            // ExpenseHeading(
            //   'R\$ $balance',
            //   size: ExpenseHeadingSize.lg,
            // ),
            ExpenseCurrency(
              price: double.parse(balance),
              size: ExpenseCurrencySize.lg,
              type: ExpenseCurrencyType.currency,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildIncome(positiveColor),
                _buildExpense(negativeColor),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpense(Color color) => Container(
        width: 200,
        decoration: BoxDecoration(
          color: aliasTokens.color.elements.bgColor02,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: aliasTokens.color.elements.negativeColor,
            width: 1,
          ),
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 10,
              children: [
                ExpenseHeading(
                  'Despesa',
                  size: ExpenseHeadingSize.sm,
                ),
                CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.white,
                  child: ExpenseIcon(
                    icon: ExpenseIcons.downLine,
                    color: color,
                  ),
                ),
              ],
            ),
            ExpenseCurrency(
              price: double.parse(expense),
              size: ExpenseCurrencySize.lg,
              type: ExpenseCurrencyType.currency,
            ),
          ],
        ),
      );

  Widget _buildIncome(Color color) => Container(
        width: 200,
        decoration: BoxDecoration(
          color: aliasTokens.color.elements.bgColor02,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: color,
            width: 1,
          ),
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spacing.s1x,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 10,
              children: [
                ExpenseHeading(
                  'Renda',
                  size: ExpenseHeadingSize.sm,
                ),
                CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.white,
                  child: ExpenseIcon(
                    icon: ExpenseIcons.upLine,
                    color: color,
                  ),
                ),
              ],
            ),
            ExpenseCurrency(
              price: double.parse(income),
              size: ExpenseCurrencySize.lg,
              type: ExpenseCurrencyType.currency,
            ),
          ],
        ),
      );
}
