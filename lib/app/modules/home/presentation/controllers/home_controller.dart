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

  Worksheet? _worksheet;

  @override
  void onInit() {
    super.onInit();
    getData();
    transactionTypeList();
    transactionTypeList1();
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
      _worksheet = repository.getWorksheet();

      final transactions = await repository.getAllTransactions();
      store.currentTransactions = transactions;
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
      store.completed();
    } catch (e) {
      store.error = e.toString();
      debugPrint(e.toString());
    }
  }

  void transactionTypeSelected(ExpenseDropdownItem? value) {
    store.selectedType = value;
  }

  void transactionTypeList() {
    store.types.value = [
      ExpenseDropdownItem(
        '0',
        'food',
      ),
      ExpenseDropdownItem(
        '1',
        'transport',
      ),
      ExpenseDropdownItem(
        '2',
        'entertainment',
      ),
      ExpenseDropdownItem(
        '3',
        'education',
      ),
      ExpenseDropdownItem(
        '4',
        'work',
      ),
      ExpenseDropdownItem(
        '5',
        'finance',
      ),
      ExpenseDropdownItem(
        '6',
        'shopping',
      ),
      ExpenseDropdownItem(
        '7',
        'health',
      ),
      ExpenseDropdownItem(
        '8',
        'home',
      ),
      ExpenseDropdownItem(
        '9',
        'gifts',
      ),
      ExpenseDropdownItem(
        '10',
        'other',
      ),
    ];
  }

  void onDeleteTransaction(int index) async {
    store.loading();
    try {
      await repository.deleteTransaction(index);
      store.completed();
    } catch (e) {
      store.error = e.toString();
      debugPrint(e.toString());
    }
  }

  void transactionTypeList1() {
    store.types1.value = [
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
      11,
      12,
    ];
  }

  String getTypeLabel(int typeId) {
    Map<int, String> typeNames = {
      0: 'Alimentação',
      1: 'Transporte',
      2: 'Entretenimento',
      3: 'Educação',
      4: 'Trabalho',
      5: 'Finanças',
      6: 'Compras',
      7: 'Saúde',
      8: 'Casa',
      9: 'Presentes',
      10: 'Salário',
      11: 'Renda Extra',
      12: 'Outros',
    };

    return typeNames[typeId] ?? 'Outros';
  }

  //   Future init() async {
  //   final ss = await _gsheets.spreadsheet(_spreadsheetId);
  //   _worksheet = ss.worksheetByTitle('Sheet1');
  //   conutRows();
  // }

  // static Future conutRows() async {
  //   while ((await _worksheet!.values.value(column: 1, row: numberOfTransactions + 1)) != '') {
  //     numberOfTransactions++;
  //   }
  //   loadTransactions();
  // }

  // static Future<void> addTransaction(String name, String amount, String type) async {
  //   await _worksheet!.values.appendRow([name, amount, type]);
  //   numberOfTransactions++;
  // }

  Future<Worksheet?> loadTransactions() async {
    if (_worksheet == null) {
      return null;
    }

    for (int i = 1; i < store.numberOfTransactions; i++) {
      final transactionName = await _worksheet!.values.value(column: 1, row: i + 1);
      final transactionAmount = await _worksheet!.values.value(column: 2, row: i + 1);
      final transactionType = await _worksheet!.values.value(column: 3, row: i + 1);

      if (store.currentTransactions.length < store.numberOfTransactions) {
        store.currentTransactions.add([transactionName, transactionAmount, transactionType]);
      }
    }
    print('currentTransactions: ${store.currentTransactions}');
    return null;
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

  // Future insertTransaction(String name, String amount, bool isIncome) async {
  //   if (_worksheet == null) {
  //     return;
  //   }

  //   store.numberOfTransactions++;
  //   store.currentTransactions.add([name, amount, isIncome ? 'income' : 'expense']);
  //   await _worksheet!.values.appendRow([name, amount, isIncome ? 'income' : 'expense']);
  // }

  // static Future deleteTransaction(int index) async {
  //   if (_worksheet == null) {
  //     return;
  //   }

  //   numberOfTransactions--;
  //   currentTransactions.removeAt(index);
  //   await _worksheet!.values.appendRow([index + 1]);
  // }

  // static Future updateTransaction(int index, String name, String amount, bool isIncome) async {
  //   if (_worksheet == null) {
  //     return;
  //   }

  //   currentTransactions[index] = [name, amount, isIncome ? 'income' : 'expense'];
  //   await _worksheet!.values.insertValue(name, column: 1, row: index + 1);
  //   await _worksheet!.values.insertValue(amount, column: 2, row: index + 1);
  //   await _worksheet!.values.insertValue(isIncome ? 'income' : 'expense', column: 3, row: index + 1);
  // }

  // static Future<void> deleteAllTransactions() async {
  //   if (_worksheet == null) {
  //     return;
  //   }

  //   for (int i = 0; i < numberOfTransactions; i++) {
  //     await _worksheet!.values.insertValue('', column: 1, row: i + 1);
  //     await _worksheet!.values.insertValue('', column: 2, row: i + 1);
  //     await _worksheet!.values.insertValue('', column: 3, row: i + 1);
  //   }
  //   numberOfTransactions = 0;
  //   currentTransactions = [];
  // }

  // static double calculateBalance() {
  //   double balance = 0;
  //   for (int i = 0; i < currentTransactions.length; i++) {
  //     balance += double.parse(currentTransactions[i][1]);
  //   }
  //   return balance;
  // }

  // static double calculateIncome() {
  //   double income = 0;
  //   for (int i = 0; i < currentTransactions.length; i++) {
  //     if (currentTransactions[i][2] == 'income') {
  //       income += double.parse(currentTransactions[i][1]);
  //     }
  //   }
  //   return income;
  // }

  // static double calculateExpense() {
  //   double expense = 0;
  //   for (int i = 0; i < currentTransactions.length; i++) {
  //     if (currentTransactions[i][2] == 'expense') {
  //       expense += double.parse(currentTransactions[i][1]);
  //     }
  //   }
  //   return expense;
  // }

  // static double calculateDifference() {
  //   return calculateIncome() - calculateExpense();
  // }
}
