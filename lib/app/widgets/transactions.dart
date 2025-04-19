import 'package:expense_app/app/commons/commons.dart';

class Transactions extends StatelessWidget with ThemeInjector {
  final String trnsactionName;
  final String transactionAmount;
  final String expenseOrIncome;

  const Transactions({
    required this.trnsactionName,
    required this.transactionAmount,
    required this.expenseOrIncome,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: sizing.s2x),
      child: Column(
        children: [
          SizedBox(height: sizing.s2x),
          Container(
            padding: EdgeInsets.all(sizing.s2x),
            decoration: BoxDecoration(
              color: aliasTokens.color.elements.bgColor01,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: aliasTokens.color.elements.bgColor03,
                width: globalTokens.shapes.border.widthSm,
              ),
              boxShadow: [
                BoxShadow(
                  color: aliasTokens.color.elements.bgColor03.withValues(alpha: globalTokens.shapes.opacity.superLow),
                  blurRadius: globalTokens.shapes.border.widthSm,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            height: spacing.s9x,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ExpenseHeading(
                  trnsactionName,
                  size: ExpenseHeadingSize.sm,
                ),
                Text(
                  expenseOrIncome == 'expense' ? '-$transactionAmount' : '+$transactionAmount',
                  style: TextStyle(
                    color: expenseOrIncome == 'expense' ? aliasTokens.color.elements.negativeColor : aliasTokens.color.positive.placeholderColor,
                    fontSize: globalTokens.typographys.fontSizeSm,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
