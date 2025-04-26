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
          ),
        ),
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
                onPressed: () => openTransactionForm(),
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
                        int index = controller.store.currentTransactions.indexOf(transaction);
                        return GestureDetector(
                          onTap: () => openTransactionForm(editMode: true, index: index),
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
                  ),
                ),
        ],
      ).paddingOnly(bottom: sizing.s12x);

  void openTransactionForm({bool editMode = false, int? index}) {
    controller.prepareForm(editMode: editMode, index: index);

    ExpenseDrawer.show(
      context,
      children: [
        Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: ExpenseHeading(
                  controller.store.isEditing.value ? 'Editar transação' : 'Adicionar transação',
                  size: ExpenseHeadingSize.sm,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: spacing.s4x),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Obx(
                    () => ExpenseRadioButton(
                      label: 'Receita',
                      value: 'income',
                      groupValue: controller.store.expenseOrIncome,
                      onChanged: (value) {
                        controller.store.expenseOrIncome = value!;
                        controller.store.isIncome = true;
                      },
                    ),
                  ),
                  Obx(
                    () => ExpenseRadioButton(
                      label: 'Despesa',
                      value: 'expense',
                      groupValue: controller.store.expenseOrIncome,
                      onChanged: (value) {
                        controller.store.expenseOrIncome = value!;
                        controller.store.isIncome = false;
                      },
                    ),
                  ),
                ],
              ),
              // No TransactionForm
              SizedBox(height: spacing.s3x),
              Obx(
                () => controller.store.typesList.isEmpty
                    ? ExpenseHeading('Nenhum tipo disponível', size: ExpenseHeadingSize.sm)
                    : Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ExpenseHeading(
                              'Tipos de Transação',
                              size: ExpenseHeadingSize.xs,
                            ),
                            SizedBox(height: spacing.s2_5x),
                            Wrap(
                              runSpacing: spacing.s2x,
                              spacing: spacing.s1x,
                              children: controller.store.typesList.map((type) {
                                return ExpenseChipSelect(
                                  key: ValueKey('chip_$type'),
                                  label: controller.getTypeLabel(type),
                                  isSelected: controller.store.transactionType == type.toString(),
                                  onPressed: (value) {
                                    controller.store.transactionType = type.toString();
                                  },
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
              ),
              SizedBox(height: spacing.s2x),
              Obx(
                () => ExpenseInputTextLine(
                  controller: controller.store.nameController,
                  label: 'Name',
                  onChanged: (value) {
                    controller.store.nameError = false;
                    controller.store.name = value;
                  },
                  supportText: controller.store.nameError ? 'Por favor digite um nome' : null,
                  hasError: controller.store.nameError,
                ),
              ),
              SizedBox(height: spacing.s1_5x),
              Obx(
                () => ExpenseInputTextLine(
                  controller: controller.store.amountController,
                  label: 'Valor',
                  onChanged: (value) {
                    controller.store.amountError = false;
                    controller.store.amount = value;
                  },
                  supportText: controller.store.amountError ? 'Por favor digite um valor' : null,
                  hasError: controller.store.amountError,
                ),
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
                    controller.store.dateError = false;
                    controller.store.date.clear();
                    if (value.isNotEmpty) {
                      controller.store.date.assign(value.first!);
                    }
                  },
                  supportText: controller.store.dateError ? 'Por favor digite uma data' : null,
                  hasError: controller.store.dateError,
                ),
              ),
              SizedBox(height: spacing.s2x),
              Row(
                mainAxisAlignment: !controller.store.isEditing.value ? MainAxisAlignment.center : MainAxisAlignment.spaceBetween,
                children: [
                  if (controller.store.isEditing.value)
                    Obx(
                      () => ExpenseButton(
                        label: 'Deletar',
                        icon: ExpenseIcons.deleteLine,
                        onPressed: () {
                          controller.deleteTransaction(
                            controller.store.currentTransactions.indexOf(controller.store.currentTransactions[index!]),
                          );
                          Modular.to.pop();
                        },
                        loading: controller.store.isLoading,
                      ),
                    ),
                  Obx(
                    () => ExpenseButton(
                      label: controller.store.isEditing.value ? 'Salvar' : 'Adicionar',
                      icon: ExpenseIcons.plusLine,
                      onPressed: () {
                        if (controller.store.name.isEmpty) {
                          controller.store.nameError = true;
                        }
                        if (controller.store.amount.isEmpty) {
                          controller.store.amountError = true;
                        }
                        if (controller.store.name.isNotEmpty && controller.store.amount.isNotEmpty) {
                          if (controller.store.isEditing.value) {
                            controller.updateTransaction();
                          } else {
                            controller.addTransaction();
                          }
                          Modular.to.pop();
                        }
                      },
                      loading: controller.store.isLoading,
                    ),
                  ),
                ],
              ).paddingOnly(bottom: spacing.s2x),
            ],
          ),
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
