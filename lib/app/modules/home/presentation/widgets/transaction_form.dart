import 'package:expense_app/app/commons/commons.dart';
import 'package:expense_app/app/modules/home/presentation/controllers/home_controller.dart';

class TransactionForm extends StatelessWidget with ThemeInjector {
  final GlobalKey<FormState> formKey;
  final HomeController controller;
  final bool editMode;
  final int? index;

  const TransactionForm({
    super.key,
    required this.formKey,
    required this.controller,
    this.editMode = false,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(
          globalTokens.shapes.border.radiusMd,
        ),
        topRight: Radius.circular(
          globalTokens.shapes.border.radiusMd,
        ),
      ),
      child: Container(
        height: MediaQuery.sizeOf(context).height * 0.85,
        decoration: BoxDecoration(color: aliasTokens.color.elements.bgColor02),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    bottom: spacing.s4x,
                    left: spacing.s1x,
                    right: spacing.s1x,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ExpenseHeading(
                        controller.store.isEditing.value ? 'Editar transação' : 'Adicionar transação',
                        size: ExpenseHeadingSize.sm,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              color: aliasTokens.color.disabled.bgColor,
                              borderRadius: BorderRadius.circular(globalTokens.shapes.border.radiusLg),
                            ),
                            padding: EdgeInsets.all(spacing.s1x),
                            child: ExpenseIcon(icon: ExpenseIcons.dropdownOpenLine)),
                      ),
                    ],
                  ),
                ),
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
                SizedBox(height: spacing.s8x),
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
                          size: ExpenseButtonSize.sm,
                        ),
                      ),
                    Obx(
                      () => Align(
                        alignment: Alignment.bottomCenter,
                        child: ExpenseButton(
                          label: controller.store.isEditing.value ? 'Salvar' : 'Adicionar',
                          icon: controller.store.isEditing.value ? ExpenseIcons.checkLine : ExpenseIcons.plusLine,
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
                          size: ExpenseButtonSize.sm,
                        ),
                      ),
                    ),
                  ],
                ).paddingOnly(bottom: spacing.s2x),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
