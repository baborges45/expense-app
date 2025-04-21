import 'package:expense_app/app/commons/commons.dart';
import 'package:expense_app/app/modules/home/presentation/widgets/home_loading.dart' show HomeLoading;
import 'package:expense_app/app/widgets/top_card.dart';
import 'package:expense_app/app/widgets/transactions.dart';
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
            )),
      );
    });
  }

  Widget _buildState(BuildContext context) => Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: aliasTokens.color.elements.bgColor02,
            ),
            height: sizing.s35x,
            child: TopCard(
              balance: controller.calculateDifference().toString(),
              expense: controller.calculateExpense().toString(),
              income: controller.calculateIncome().toString(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                child: ExpenseHeading(
                  'Transactions',
                  size: ExpenseHeadingSize.md,
                ),
              ),
              ExpenseButton(
                label: 'Adicionar transação',
                icon: ExpenseIcons.plusLine,
                onPressed: () {
                  setState(() {
                    ExpenseDrawer.show(
                      context,
                      children: [
                        Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  Obx(
                                    () => ExpenseSwitch(
                                      label: controller.store.expenseOrIncome == 'income' ? 'Renda' : 'Despesa',
                                      value: controller.store.isIncome,
                                      onChanged: (value) {
                                        controller.store.isIncome = value;
                                        controller.store.expenseOrIncome = value ? 'income' : 'expense';
                                        print('isIncome: ${controller.store.isIncome}');
                                        print('expenseOrIncome: ${controller.store.expenseOrIncome}');
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spacing.s2x),
                              Wrap(
                                runSpacing: spacing.s2x,
                                spacing: spacing.s1x,
                                children: [
                                  ...controller.store.types1.map((type) {
                                    return Obx(
                                      () => ExpenseChipSelect(
                                        label: controller.getTypeLabel(type),
                                        isSelected: controller.store.transactionType == type.toString(),
                                        onPressed: (value) {
                                          if (controller.store.transactionType != type.toString()) {
                                            controller.store.transactionType = type.toString();
                                          }
                                        },
                                      ),
                                    );
                                  }),
                                ],
                              ),
                              SizedBox(height: spacing.s2x),
                              ExpenseInputTextLine(
                                label: 'Name',
                                onChanged: (value) {
                                  controller.store.nameError = false;
                                  controller.store.name = value;
                                },
                                supportText: controller.store.nameError ? 'Por favor digite um nome' : null,
                                hasError: controller.store.nameError,
                              ),
                              SizedBox(height: spacing.s1_5x),
                              ExpenseInputTextLine(
                                label: 'Valor',
                                onChanged: (value) {
                                  controller.store.amountError = false;
                                  controller.store.amount = value;
                                },
                                supportText: controller.store.amountError ? 'Por favr digite um valor' : null,
                                hasError: controller.store.amountError,
                              ),
                              SizedBox(height: spacing.s1_5x),
                              Obx(
                                () => ExpenseInputDateLine(
                                  value: controller.store.date.toList(),
                                  buttonLabel: 'Confirma',
                                  firstDate: DateTime(1800),
                                  lastDate: DateTime(2050),
                                  label: 'Data da transação',
                                  onConfirm: (value) {
                                    controller.store.date.clear();
                                    if (value.isNotEmpty) {
                                      if (value.first != null) {
                                        controller.store.date.assign(value.first!);
                                      }
                                    }
                                  },
                                ),
                              ),
                              SizedBox(height: spacing.s2x),
                              Obx(
                                () => ExpenseButton(
                                  label: 'Add',
                                  icon: ExpenseIcons.plusLine,
                                  onPressed: () {
                                    if (controller.store.name.isEmpty) {
                                      controller.store.nameError = true;
                                    }
                                    if (controller.store.amount.isEmpty) {
                                      controller.store.amountError = true;
                                    }
                                    if (controller.store.name.isNotEmpty && controller.store.amount.isNotEmpty) {
                                      addTransaction();
                                      controller.store.name = '';
                                      controller.store.amount = '';
                                      controller.store.nameError = false;
                                      controller.store.amountError = false;
                                      controller.store.date.clear();
                                      controller.store.transactionType = '';
                                      Modular.to.pop();
                                    }
                                  },
                                  loading: controller.store.isLoading,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  });
                },
                size: ExpenseButtonSize.sm,
              )
            ],
          ).paddingSymmetric(horizontal: sizing.s2x, vertical: sizing.s2_5x),
          controller.store.currentTransactions.isEmpty
              ? ExpenseHeading(
                  'Nenhuma transação encontrada',
                  size: ExpenseHeadingSize.sm,
                  textAlign: TextAlign.center,
                ).paddingOnly(top: sizing.s15x)
              : Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: controller.store.currentTransactions.map((transaction) {
                        return Transactions(
                          trnsactionName: transaction[0],
                          transactionAmount: transaction[1],
                          expenseOrIncome: transaction[2],
                          dateTransaction: transaction[3],
                          transactionType: transaction[4],
                        );
                      }).toList(),
                    ),
                  ),
                ),
        ],
      ).paddingOnly(bottom: sizing.s12x);

  void addTransaction() {
    controller.onAddTransaction(
      controller.store.name,
      controller.store.amount,
      controller.store.isIncome,
      controller.store.date.first.toString(),
      controller.store.transactionType,
    );
  }

  ExpenseHeadingType _mapTransactionType(String type) {
    switch (type.toLowerCase()) {
      case 'food':
        return ExpenseHeadingType.food;
      case 'transport':
        return ExpenseHeadingType.transport;
      case 'shopping':
        return ExpenseHeadingType.shopping;
      case 'education':
        return ExpenseHeadingType.education;
      case 'work':
        return ExpenseHeadingType.work;
      case 'finance':
        return ExpenseHeadingType.finance;
      case 'entertainment':
        return ExpenseHeadingType.entertainment;
      case 'health':
        return ExpenseHeadingType.health;
      case 'home':
        return ExpenseHeadingType.home;
      case 'gifts':
        return ExpenseHeadingType.gifts;
      default:
        return ExpenseHeadingType.other;
    }
  }
}
