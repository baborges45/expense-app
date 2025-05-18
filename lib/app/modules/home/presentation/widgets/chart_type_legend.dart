import 'package:expense_app/app/commons/commons.dart';

class ChartTypeLegend extends StatelessWidget with ThemeInjector {
  final Color color;
  final String label;

  const ChartTypeLegend({
    super.key,
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 15,
          height: 15,
          decoration: ShapeDecoration(
            color: aliasTokens.color.elements.bgColor01,
            shape: CircleBorder(
              side: BorderSide(width: 4, color: color),
            ),
          ),
        ),
        ExpenseHeading(
          ' $label',
          size: ExpenseHeadingSize.xs,
        ),
      ],
    );
  }
}
