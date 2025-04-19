import 'package:expense_app/app/models/expense.dart';
import 'package:flutter/widgets.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class ExpenseDatabase extends ChangeNotifier {
  static late Isar isar;
  List<Expense> _allExpenses = [];

  List<Expense> get expenses => _allExpenses;

  static Future<void> initialize() async {
    // Initialize the database
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([ExpenseSchema], directory: dir.path);
  }

  List<Expense> get allExpenses => _allExpenses;

  Future<void> createExpense(Expense newExpense) async {
    await isar.writeTxn(() => isar.expenses.put(newExpense));
    _allExpenses.add(newExpense);

    await readExpense();
    notifyListeners();
  }

  Future<void> readExpense() async {
    List<Expense> fetchExpenses = await isar.expenses.where().findAll();
    _allExpenses.clear();
    _allExpenses.addAll(fetchExpenses);
    notifyListeners();
  }

  Future<void> updateExpense(int id, Expense updateExpense) async {
    updateExpense.id = id;
    await isar.writeTxn(() => isar.expenses.put(updateExpense));

    await readExpense();
    notifyListeners();
  }

  Future<void> deleteExpense(int id) async {
    await isar.writeTxn(() => isar.expenses.delete(id));

    await readExpense();
    notifyListeners();
  }

  void addExpense(Expense expense) {
    _allExpenses.add(expense);
    notifyListeners();
  }

  void removeExpense(Expense expense) {
    _allExpenses.remove(expense);
    notifyListeners();
  }
}
