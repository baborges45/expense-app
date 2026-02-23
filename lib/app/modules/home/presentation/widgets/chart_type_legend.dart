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
          width: sizing.s2x,
          height: sizing.s2x,
          decoration: ShapeDecoration(
            color: aliasTokens.color.elements.bgColor01,
            shape: CircleBorder(
              side: BorderSide(width: sizing.half, color: color),
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
