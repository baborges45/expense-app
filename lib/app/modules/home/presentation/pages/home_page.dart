import 'package:expense_app/app/commons/commons.dart';
import 'package:expense_app/app/modules/home/presentation/widgets/home_loading.dart' show HomeLoading;
import 'package:expense_app/app/modules/home/presentation/widgets/transaction_form.dart';
import 'package:expense_app/app/widgets/top_card.dart';
import 'package:flutter/material.dart';

import '../controllers/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ModularInjector<HomePage, HomeController> with ThemeInjector {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: aliasTokens.color.elements.bgColor01,
          body: StateObserver(
            state: controller.store.status,
            onLoading: (_) => const HomeLoading(),
            onError: (error) => Center(
              child: Text(
                error.toString(),
                style: TextStyle(color: aliasTokens.color.elements.onIconColor),
              ),
            ),
            onCompleted: (context) => _buildState(context),
          ),
        ),
      );
    });
  }

  Widget _buildState(BuildContext context) => SingleChildScrollView(
        child: Column(
          children: [
            TopCard(
              balance: controller.calculateDifference().toString(),
              expense: controller.calculateExpense().toString(),
              income: controller.calculateIncome().toString(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(
                  child: ExpenseHeading(
                    'Transações',
                    size: ExpenseHeadingSize.sm,
                  ),
                ),
                Container(
                  width: sizing.s5x,
                  height: sizing.s5x,
                  decoration: ShapeDecoration(
                    color: aliasTokens.color.elements.bgColor01,
                    shape: CircleBorder(
                      side: BorderSide(width: sizing.half, color: aliasTokens.color.elements.bgColor06),
                    ),
                    shadows: [
                      BoxShadow(
                        color: aliasTokens.color.elements.bgColor06.withValues(alpha: 0.2),
                        spreadRadius: sizing.half,
                        blurRadius: sizing.half,
                        offset: const Offset(1, 0),
                      ),
                    ],
                  ),
                  child: ExpenseButtonIcon(
                    icon: ExpenseIcons.plusLine,
                    onPressed: () => openTransactionForm(),
                  ),
                )
              ],
            ).paddingSymmetric(horizontal: sizing.s2x, vertical: sizing.s2x),
            controller.store.currentTransactions.isEmpty
                ? ExpenseHeading(
                    'Nenhuma transação encontrada',
                    size: ExpenseHeadingSize.sm,
                    textAlign: TextAlign.center,
                  ).paddingOnly(top: sizing.s15x)
                : Column(
                    children: controller.store.currentTransactions.map((transaction) {
                      return GestureDetector(
                        onTap: () => openTransactionForm(editMode: true, index: controller.store.currentTransactions.indexOf(transaction)),
                        child: Transactions(
                          trnsactionName: transaction[0],
                          transactionAmount: transaction[1],
                          expenseOrIncome: transaction[2],
                          dateTransaction: transaction[3],
                          transactionType: transaction[4],
                        ),
                      );
                    }).toList(),
                  ),
          ],
        ).paddingOnly(bottom: sizing.s12x),
      );

  void openTransactionForm({bool editMode = false, int? index}) {
    controller.prepareForm(editMode: editMode, index: index);

    ExpenseDrawer.show(
      context,
      children: [
        TransactionForm(
          formKey: _formKey,
          controller: controller,
          editMode: editMode,
          index: index,
        ),
      ],
    );
  }

  @override
  void dispose() {
    controller.store.nameController.dispose();
    controller.store.amountController.dispose();
    controller.store.dateController.dispose();
    controller.store.transactionTypeController.dispose();
    super.dispose();
  }
}
