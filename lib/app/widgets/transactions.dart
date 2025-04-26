import 'package:expense_app/app/commons/commons.dart';

class Transactions extends StatelessWidget with ThemeInjector {
  final String trnsactionName;
  final String transactionAmount;
  final String expenseOrIncome;
  final String dateTransaction;
  final String transactionType;

  const Transactions({
    required this.trnsactionName,
    required this.transactionAmount,
    required this.expenseOrIncome,
    required this.dateTransaction,
    required this.transactionType,
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
                  type: _mapTransactionType(transactionType),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: ExpenseCurrency(
                        price: double.parse(transactionAmount),
                        size: ExpenseCurrencySize.sm,
                        type: expenseOrIncome == 'expense' ? ExpenseCurrencyType.outcome : ExpenseCurrencyType.income,
                        semanticsLabel: 'Valor do ${expenseOrIncome == 'expense' ? 'despesa' : 'receita'}',
                        semanticsHint: 'Valor do ${expenseOrIncome == 'expense' ? 'despesa' : 'receita'}',
                        excludeSemantics: true,
                      ),
                    ),
                    SizedBox(height: spacing.s1x),
                    Expanded(
                      child: ExpenseHeading(
                        formatDate(dateTransaction),
                        size: ExpenseHeadingSize.xxs,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ExpenseHeadingType _mapTransactionType(String type) {
    switch (type) {
      case 'Alimentação':
        return ExpenseHeadingType.food;
      case 'Transporte':
        return ExpenseHeadingType.transport;
      case 'Compras':
        return ExpenseHeadingType.shopping;
      case 'Educação':
        return ExpenseHeadingType.education;
      case 'Trabalho':
        return ExpenseHeadingType.work;
      case 'Finanças':
        return ExpenseHeadingType.finance;
      case 'Entretenimento':
        return ExpenseHeadingType.entertainment;
      case 'Saúde':
        return ExpenseHeadingType.health;
      case 'Casa':
        return ExpenseHeadingType.home;
      case 'Presentes':
        return ExpenseHeadingType.gifts;
      case 'Salário':
        return ExpenseHeadingType.finance;
      case 'Renda Extra':
        return ExpenseHeadingType.finance;
      case 'Outros':
        return ExpenseHeadingType.other;
      default:
        return ExpenseHeadingType.other;
    }
  }
}
