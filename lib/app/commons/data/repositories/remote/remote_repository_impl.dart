import 'dart:convert';
import 'dart:core';

import 'package:expense_app/app/commons/commons.dart';

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
  static final _spreadsheetId = '11r8qp8oJBKZZkxH_YJOQSYD3YRiKAWsfd69V3WQPg5M';
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
  Future<List<List<dynamic>>> getAllTransactions() async {
    if (_worksheet == null) return [];

    final rows = await _worksheet!.values.allRows();
    if (rows.length <= 1) return [];

    final dataRows = rows.sublist(1);

    numberOfTransactions = dataRows.length;
    currentTransactions = dataRows;

    return dataRows;
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
  Future<void> insertTransaction(String name, String amount, bool isIncome, String date) async {
    if (_worksheet == null) return;

    final newRow = [name, amount, isIncome ? 'income' : 'expense', date];
    await _worksheet!.values.appendRow(newRow);

    // Atualiza cache manualmente
    currentTransactions.add(newRow);
    numberOfTransactions++;
  }

  @override
  Future<void> deleteTransaction(int index) async {
    await datasource.googleSheets(
      action: 'delete',
      url: 'https://sheets.googleapis.com/v4/spreadsheets',
      data: {
        'spreadsheetId': _spreadsheetId,
        'index': index,
      },
    );
  }

  @override
  Future<void> updateTransaction(int index, String name, String amount, bool isIncome) {
    // TODO: implement updateTransaction
    throw UnimplementedError();
  }
}
