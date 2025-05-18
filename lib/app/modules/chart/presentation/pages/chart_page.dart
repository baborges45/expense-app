import 'package:expense_app/app/commons/commons.dart';
import 'package:expense_app/app/modules/chart/presentation/controllers/chart_controller.dart';
import 'package:expense_app/app/modules/home/presentation/widgets/chart_type_legend.dart';
import 'package:expense_app/app/widgets/carousel_chart_widget.dart';
import 'package:expense_app/app/widgets/get_color_type.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartPage extends StatefulWidget with ThemeInjector {
  const ChartPage({super.key});

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends ModularInjector<ChartPage, ChartController> with ThemeInjector, TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: aliasTokens.color.elements.bgColor01,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: spacing.s9x,
            ),
            const ExpenseHeading(
              'Histórico',
              size: ExpenseHeadingSize.md,
            ).onlyPadding(left: sizing.s2x),
            SizedBox(
              height: spacing.s4x,
            ),
            _buildCardInformation(media),
            SizedBox(height: spacing.s2x),
            controller.store.currentTransactions.isEmpty
                ? ExpenseHeading(
                    'Nenhuma transação encontrada',
                    size: ExpenseHeadingSize.sm,
                    textAlign: TextAlign.center,
                  ).paddingOnly(top: sizing.s15x)
                : Column(
                    children: controller.store.expenseTransactions.map((transaction) {
                      return Transactions(
                        trnsactionName: transaction[0],
                        transactionAmount: transaction[1],
                        expenseOrIncome: transaction[2],
                        dateTransaction: transaction[3],
                        transactionType: transaction[4],
                      );
                    }).toList(),
                  ),
          ],
        ).paddingOnly(bottom: sizing.s14x),
      ),
    );
  }

  Widget _buildCardInformation(Size size) => Container(
        decoration: BoxDecoration(
          color: aliasTokens.color.elements.bgColor02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: spacing.s3x,
                right: spacing.s3x,
                top: spacing.s3x,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ExpenseHeading(
                    'Histórico de despesas',
                    size: ExpenseHeadingSize.xl,
                  ),
                  SizedBox(
                    height: spacing.s1x,
                  ),
                  const ExpenseDescription(
                    'Detalhes do consumo',
                  ).onlyPadding(left: spacing.s1x),
                ],
              ),
            ),
            Obx(
              () => CarouselItemChart(
                onPressed: () {},
                carouselItems: [
                  PieChart(
                    PieChartData(
                      centerSpaceRadius: 100,
                      sectionsSpace: 0,
                      startDegreeOffset: 180,
                      sections: controller.store.expenseTransactions
                          .map((e) => PieChartSectionData(
                                color: TransactionTypeColor().getColor(e[4]),
                                value: double.parse(e[1]),
                                title: e[0],
                                radius: 15,
                                showTitle: true,
                                titlePositionPercentageOffset: double.parse(e[1]),
                                titleStyle: TextStyle(
                                  fontSize: 12,
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spacing.s3x,
                    children: controller.store.expenseTransactions.map((transaction) => transaction[4]).toSet().map((uniqueType) {
                      double value = controller.store.expenseTransactions
                          .where((e) => e[4] == uniqueType)
                          .fold(0, (previousValue, element) => previousValue + double.parse(element[1]));
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ChartTypeLegend(
                            color: TransactionTypeColor().getColor(uniqueType),
                            label: uniqueType,
                          ),
                          ExpenseCurrency(
                            price: value,
                            size: ExpenseCurrencySize.sm,
                            type: ExpenseCurrencyType.outcome,
                          ),
                        ],
                      );
                    }).toList(),
                  ).paddingOnly(
                    top: spacing.s9x,
                  ),
                ],
                pageController: PageController(
                  viewportFraction: controller.store.currentPage.value == 0.0 ? 0.85 : 1.0,
                ),
              ),
            ),
          ],
        ),
      );
}
