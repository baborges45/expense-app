import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gsheets/gsheets.dart';

class GoogleSheetsApi {
  static final credentials = dotenv.env['GOOGLE_CREDENTIALS'] != null
      ? jsonDecode(dotenv.env['GOOGLE_CREDENTIALS']!)
      : throw Exception('GOOGLE_CREDENTIALS não encontrado no arquivo .env');
  static final _spreadsheetId = '11r8qp8oJBKZZkxH_YJOQSYD3YRiKAWsfd69V3WQPg5M';
  static final _gsheets = GSheets(credentials);
  static Worksheet? _worksheet;

  static int numberOfTransactions = 0;
  static List<List<dynamic>> currentTransactions = [];
  static bool isLoaded = true;

  Future init() async {
    final ss = await _gsheets.spreadsheet(_spreadsheetId);
    _worksheet = ss.worksheetByTitle('Sheet1');
    conutRows();
  }

  static Future conutRows() async {
    while ((await _worksheet!.values.value(column: 1, row: numberOfTransactions + 1)) != '') {
      numberOfTransactions++;
    }
    loadTransactions();
  }

  static Future<void> addTransaction(String name, String amount, String type) async {
    await _worksheet!.values.appendRow([name, amount, type]);
    numberOfTransactions++;
  }

  static Future loadTransactions() async {
    if (_worksheet == null) {
      return;
    }

    for (int i = 1; i < numberOfTransactions; i++) {
      final transactionName = await _worksheet!.values.value(column: 1, row: i + 1);
      final transactionAmount = await _worksheet!.values.value(column: 2, row: i + 1);
      final transactionType = await _worksheet!.values.value(column: 3, row: i + 1);

      if (currentTransactions.length < numberOfTransactions) {
        currentTransactions.add([transactionName, transactionAmount, transactionType]);
      }
    }
    print(currentTransactions);
    isLoaded = false;
  }

  static Future insertTransaction(String name, String amount, bool isIncome) async {
    if (_worksheet == null) {
      return;
    }

    numberOfTransactions++;
    currentTransactions.add([name, amount, isIncome ? 'income' : 'expense']);
    await _worksheet!.values.appendRow([name, amount, isIncome ? 'income' : 'expense']);
  }

  static Future deleteTransaction(int index) async {
    if (_worksheet == null) {
      return;
    }

    numberOfTransactions--;
    currentTransactions.removeAt(index);
    await _worksheet!.values.appendRow([index + 1]);
  }

  static Future updateTransaction(int index, String name, String amount, bool isIncome) async {
    if (_worksheet == null) {
      return;
    }

    currentTransactions[index] = [name, amount, isIncome ? 'income' : 'expense'];
    await _worksheet!.values.insertValue(name, column: 1, row: index + 1);
    await _worksheet!.values.insertValue(amount, column: 2, row: index + 1);
    await _worksheet!.values.insertValue(isIncome ? 'income' : 'expense', column: 3, row: index + 1);
  }

  static Future<void> deleteAllTransactions() async {
    if (_worksheet == null) {
      return;
    }

    for (int i = 0; i < numberOfTransactions; i++) {
      await _worksheet!.values.insertValue('', column: 1, row: i + 1);
      await _worksheet!.values.insertValue('', column: 2, row: i + 1);
      await _worksheet!.values.insertValue('', column: 3, row: i + 1);
    }
    numberOfTransactions = 0;
    currentTransactions = [];
  }

  static double calculateBalance() {
    double balance = 0;
    for (int i = 0; i < currentTransactions.length; i++) {
      balance += double.parse(currentTransactions[i][1]);
    }
    return balance;
  }

  static double calculateIncome() {
    double income = 0;
    for (int i = 0; i < currentTransactions.length; i++) {
      if (currentTransactions[i][2] == 'income') {
        income += double.parse(currentTransactions[i][1]);
      }
    }
    return income;
  }

  static double calculateExpense() {
    double expense = 0;
    for (int i = 0; i < currentTransactions.length; i++) {
      if (currentTransactions[i][2] == 'expense') {
        expense += double.parse(currentTransactions[i][1]);
      }
    }
    return expense;
  }

  static double calculateDifference() {
    return calculateIncome() - calculateExpense();
  }
}
