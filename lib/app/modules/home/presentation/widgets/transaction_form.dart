import 'package:expense_app/app/commons/commons.dart';
import 'package:expense_app/app/modules/home/presentation/controllers/home_controller.dart';

class TransactionForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final HomeController controller;

  const TransactionForm({
    super.key,
    required this.controller,
    required this.formKey,
  });

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends ModularInjector<TransactionForm, HomeController> with ThemeInjector {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
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
          SizedBox(height: spacing.s3x),
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
          ExpenseInputTextLine(
            controller: controller.store.nameController,
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
            controller: controller.store.amountController,
            label: 'Valor',
            onChanged: (value) {
              controller.store.amountError = false;
              controller.store.amount = value;
            },
            supportText: controller.store.amountError ? 'Por favor digite um valor' : null,
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
                  controller.store.date.assign(value.first!);
                }
              },
            ),
          ),
          SizedBox(height: spacing.s2x),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (controller.store.isEditing.value)
                Obx(
                  () => ExpenseButton(
                    label: 'Deletar',
                    icon: ExpenseIcons.deleteLine,
                    onPressed: () {
                      deleteTransaction();
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
                        updateTransaction();
                      } else {
                        addTransaction();
                      }
                      controller.clearFields();
                      controller.clearEditing();
                      Modular.to.pop();
                    }
                  },
                  loading: controller.store.isLoading,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void addTransaction() {
    widget.controller.onAddTransaction(
      widget.controller.store.name,
      widget.controller.store.amount,
      widget.controller.store.isIncome,
      widget.controller.store.date.first.toString(),
      widget.controller.store.transactionType,
    );
  }

  void updateTransaction() {
    widget.controller.onUpdateTransaction(
      widget.controller.store.editingIndex!.value,
      widget.controller.store.name,
      widget.controller.store.amount,
      widget.controller.store.isIncome,
      widget.controller.store.date.first.toString(),
      widget.controller.store.transactionType,
    );
  }

  void deleteTransaction() {
    widget.controller.onDeleteTransaction(widget.controller.store.editingIndex!.value);
  }
}
