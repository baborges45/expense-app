import 'package:expense_app/app/commons/commons.dart';

class ChartStore extends StateStore {
  final _isIncome = false.obs;
  bool get isIncome => _isIncome.value;
  set isIncome(bool value) => _isIncome.value = value;

  final _expenseOrIncome = ''.obs;
  String get expenseOrIncome => _expenseOrIncome.value;
  set expenseOrIncome(String value) => _expenseOrIncome.value = value;

  final types = RxList<ExpenseDropdownItem>();
  final typesList = RxList<int>();

  int numberOfTransactions = 0;
  final RxDouble currentPage = 0.0.obs;

  final _currentTransactions = RxList<List<dynamic>>([]);
  List<List<dynamic>> get currentTransactions => _currentTransactions;
  RxList<List<dynamic>> get currentTransactionsRx => _currentTransactions;
  set currentTransactions(List<List<dynamic>> value) => _currentTransactions.value = value;

  final _expenseTransactions = RxList<List<dynamic>>([]);
  List<List<dynamic>> get expenseTransactions => _expenseTransactions;
  RxList<List<dynamic>> get expenseTransactionsRx => _expenseTransactions;
  set expenseTransactions(List<List<dynamic>> value) => _expenseTransactions.value = value;

  String typeTransaction = '';
}
