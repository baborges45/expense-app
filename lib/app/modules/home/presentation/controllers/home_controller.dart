import 'dart:async';

import 'package:expense_app/app/commons/commons.dart';

import '../stores/home_store.dart';

class HomeController extends PageLifeCycleController {
  final ApiRepository repository;
  @override
  final HomeStore store;
  final AppStore appStore;

  HomeController({
    required this.store,
    required this.appStore,
    required this.repository,
  });

  @override
  void onInit() {
    super.onInit();
    getData();
    transactionTypeList();
  }

  void startLoading() {
    store.timeHasStarted.value = true;
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (store.isLoading == false) {
        store.timeHasStarted.value = false;
        timer.cancel();
      }
    });
  }

  Future<void> getData() async {
    store.loading();
    try {
      await repository.initGoogleSheets();

      final transactions = await repository.getAllTransactions();

      appStore.transactions = transactions;
      store.currentTransactions = transactions.map((transaction) {
        final Map<String, dynamic> json = transaction.toJson();
        return [
          json['name'] ?? '',
          json['amount'] ?? '',
          json['expenseOrIncome'] ?? '',
          json['date'] ?? '',
          json['transactionType'] ?? '',
        ];
      }).toList();
      store.numberOfTransactions = transactions.length;

      store.completed();
    } catch (e) {
      store.error = e.toString();
      debugPrint(e.toString());
    }
  }

  void onAddTransaction(
    String name,
    String amount,
    bool isIncome,
    String date,
    String transactionType,
  ) async {
    store.loading();
    try {
      await repository.insertTransaction(
        name,
        amount,
        isIncome,
        convertDateToSave(date),
        getTypeLabel(int.parse(transactionType)),
      );
      getData();
    } catch (e) {
      store.error = e.toString();
      debugPrint(e.toString());
    }
  }

  void transactionTypeSelected(ExpenseDropdownItem? value) {
    store.selectedType = value;
  }

  void onDeleteTransaction(int index) async {
    store.loading();
    try {
      await repository.deleteTransaction(index);
      getData();
    } catch (e) {
      store.error = e.toString();
      debugPrint(e.toString());
    }
  }

  void onUpdateTransaction(
    int index,
    String name,
    String amount,
    bool isIncome,
    String date,
    String transactionType,
  ) async {
    store.loading();
    try {
      await repository.updateTransaction(
        index,
        name,
        amount,
        isIncome,
        convertDateToSave(date),
        transactionType,
      );
      getData();
    } catch (e) {
      store.error = e.toString();
      debugPrint(e.toString());
    }
  }

  void transactionTypeList() {
    store.typesList.value = [
      0,
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9,
      10,
    ];
  }

  String getTypeLabel(int typeId) {
    Map<int, String> typeNames = {
      0: 'Alimentação',
      1: 'Transporte',
      2: 'Entretenimento',
      3: 'Educação',
      4: 'Finanças',
      5: 'Compras',
      6: 'Saúde',
      7: 'Casa',
      8: 'Presentes',
      9: 'Renda Extra',
      10: 'Outros',
    };

    return typeNames[typeId] ?? 'Outros';
  }

  int getIntLabel(String type) {
    Map<String, int> typeNames = {
      'Alimentação': 0,
      'Transporte': 1,
      'Entretenimento ': 2,
      'Educação': 3,
      'Finanças': 4,
      'Compras': 5,
      'Saúde': 6,
      'Casa': 7,
      'Presentes': 8,
      'Renda Extra': 9,
      'Outros': 10,
    };

    return typeNames[type] ?? 0;
  }

  double calculateBalance() {
    double balance = 0;
    for (int i = 0; i < store.currentTransactions.length; i++) {
      balance += double.parse(store.currentTransactions[i][1]);
    }
    return balance;
  }

  double calculateIncome() {
    double income = 0;
    for (int i = 0; i < store.currentTransactions.length; i++) {
      if (store.currentTransactions[i][2] == 'income') {
        income += double.parse(store.currentTransactions[i][1]);
      }
    }
    return income;
  }

  double calculateExpense() {
    double expense = 0;
    for (int i = 0; i < store.currentTransactions.length; i++) {
      if (store.currentTransactions[i][2] == 'expense') {
        expense += double.parse(store.currentTransactions[i][1]);
      }
    }
    return expense;
  }

  double calculateDifference() {
    return calculateIncome() - calculateExpense();
  }

  void clearEditing() {
    store.isEditing.value = false;
    store.editingIndex = null;
    store.nameController.clear();
    store.amountController.clear();
    store.dateController.clear();
    store.transactionTypeController.clear();
  }

  void clearFields() {
    store.nameController.clear();
    store.amountController.clear();
    store.dateController.clear();
    store.transactionTypeController.clear();
    store.name = '';
    store.amount = '';
    store.nameError = false;
    store.amountError = false;
    store.date.clear();
    store.transactionType = '';
  }

  void prepareForm({bool editMode = false, int? index}) {
    store.isEditing.value = editMode;
    store.editingIndex = index?.obs;

    if (editMode && index != null) {
      final transaction = store.currentTransactions[index];
      store.nameController.text = transaction[0];
      store.amountController.text = transaction[1];
      store.dateController.text = transaction[3];
      store.transactionTypeController.text = transaction[4];
      store.name = transaction[0];
      store.amount = transaction[1];
      store.isIncome = transaction[2] == 'income';
      store.expenseOrIncome = transaction[2];
      try {
        final parsedDate = DateFormat('dd/MM/yyyy').parse(transaction[3]);
        store.date.assign(parsedDate);
      } catch (e) {
        debugPrint('Erro ao converter a data: $e');
      }
      store.transactionType = transaction[4];
    } else {
      clearFields();
    }
  }

  String? validateFields() {
    bool hasError = false;

    if (store.nameController.text.isEmpty) {
      store.nameError = true;
      hasError = true;
    } else {
      store.nameError = false;
    }

    if (store.amountController.text.isEmpty) {
      store.amountError = true;
      hasError = true;
    } else {
      store.amountError = false;
    }

    if (store.date.isEmpty) {
      store.dateError = true;
      hasError = true;
    } else {
      store.dateError = false;
    }

    if (store.transactionType.isEmpty) {
      store.transactionTypeError = true;
      hasError = true;
    } else {
      store.transactionTypeError = false;
    }

    return hasError ? 'Por favor, preencha todos os campos obrigatórios' : null;
  }

  void addTransaction() {
    store.name = store.nameController.text;
    store.amount = store.amountController.text;
    onAddTransaction(
      store.name,
      store.amount,
      store.isIncome,
      store.date.first.toString(),
      store.transactionType,
    );
    clearFields();
  }

  void updateTransaction() {
    store.name = store.nameController.text;
    store.amount = store.amountController.text;
    onUpdateTransaction(
      store.editingIndex!.value,
      store.name,
      store.amount,
      store.isIncome,
      store.date.first.toString(),
      store.transactionType,
    );
    clearFields();
  }

  void deleteTransaction(int index) {
    onDeleteTransaction(store.editingIndex!.value);
    clearFields();
  }
}
