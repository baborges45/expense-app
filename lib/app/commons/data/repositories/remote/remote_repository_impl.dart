import 'dart:convert';
import 'dart:core';

import 'package:expense_app/app/commons/commons.dart';
import 'package:expense_app/app/commons/domain/entities/transaction_entity.dart';

class ApiRepositoryImpl implements ApiRepository {
  final HttpAdapter datasource;
  final LocalRepository localStorage;

  ApiRepositoryImpl({
    required this.datasource,
    required this.localStorage,
  });

  static final credentials = dotenv.env['GOOGLE_CREDENTIALS'] != null
      ? jsonDecode(dotenv.env['GOOGLE_CREDENTIALS']!)
      : throw Exception('GOOGLE_CREDENTIALS não encontrado no arquivo .env');
  static final _spreadsheetId = dotenv.env['SPREADSHEET_ID'] ?? (throw Exception('SPREADSHEET_ID não encontrado no arquivo .env'));
  static final _gsheets = GSheets(credentials);
  static Worksheet? _worksheet;

  static int numberOfTransactions = 0;
  static List<List<dynamic>> currentTransactions = [];

  @override
  Future<void> initGoogleSheets() async {
    final ss = await _gsheets.spreadsheet(_spreadsheetId);
    _worksheet = ss.worksheetByTitle('Sheet1');
  }

  @override
  Worksheet? getWorksheet() {
    return _worksheet;
  }

  @override
  Future<List<TransactionEntity>> getAllTransactions() async {
    if (_worksheet == null) return [];

    final rows = await _worksheet!.values.allRows();
    if (rows.length <= 1) return [];

    final dataRows = rows.sublist(1);

    numberOfTransactions = dataRows.length;
    currentTransactions = dataRows;

    final transactionList = dataRows.map((row) {
      return TransactionEntity(
        id: dataRows.indexOf(row).toString(),
        name: row[0].toString(),
        amount: row[1].toString(),
        expenseOrIncome: row[2].toString(),
        date: row[3].toString(),
        transactionType: row[4].toString(),
      );
    }).toList();

    return transactionList;
  }

  @override
  Future<void> addTransaction(String name, String amount, bool isIncome) async {
    await datasource.googleSheets(
      action: 'add',
      url: 'https://sheets.googleapis.com/v4/spreadsheets',
      data: {
        'spreadsheetId': _spreadsheetId,
        'name': name,
        'amount': amount,
        'type': isIncome ? 'income' : 'expense',
      },
    );
  }

  @override
  Future<void> insertTransaction(
    String name,
    String amount,
    bool isIncome,
    String date,
    String transactionType,
  ) async {
    if (_worksheet == null) return;

    final newRow = [name, amount, isIncome ? 'income' : 'expense', date, transactionType];
    await _worksheet!.values.appendRow(newRow);

    currentTransactions.add(newRow);
    numberOfTransactions++;
    await getAllTransactions();
  }

  @override
  Future<void> deleteTransaction(int index) async {
    if (_worksheet == null) return;

    if (index < 0 || index >= currentTransactions.length) {
      throw Exception('Índice inválido para deletar transação.');
    }

    final success = await _worksheet!.deleteRow(index + 2);
    if (!success) {
      throw Exception('Falha ao deletar a linha na planilha.');
    }

    currentTransactions.removeAt(index);
    numberOfTransactions--;

    await getAllTransactions();
  }

  @override
  Future<void> updateTransaction(
    int index,
    String name,
    String amount,
    bool isIncome,
    String date,
    String transactionType,
  ) async {
    if (_worksheet == null) return;

    currentTransactions[index] = [
      name,
      amount,
      isIncome ? 'income' : 'expense',
      date,
      transactionType,
    ].cast<String>();

    final row = index + 2;

    await _worksheet!.values.insertValue(name, column: 1, row: row);
    await _worksheet!.values.insertValue(amount, column: 2, row: row);
    await _worksheet!.values.insertValue(isIncome ? 'income' : 'expense', column: 3, row: row);
    await _worksheet!.values.insertValue(date, column: 4, row: row);
    await _worksheet!.values.insertValue(transactionType, column: 5, row: row);

    await getAllTransactions();
  }
}
