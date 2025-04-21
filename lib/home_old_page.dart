import 'dart:async';

import 'package:expense_app/google_sheets_api.dart';
import 'package:expense_app/app/widgets/top_card.dart';
import 'package:expense_app/app/widgets/plus_button.dart';
import 'package:expense_app/app/widgets/transactions.dart';
import 'package:flutter/material.dart';

import 'app/commons/commons.dart';

class HomeOldPage extends StatefulWidget {
  const HomeOldPage({super.key});

  @override
  State<HomeOldPage> createState() => _HomeOldPageState();
}

class _HomeOldPageState extends State<HomeOldPage> with ThemeInjector {
  bool timeHasStatred = false;
  bool _isIncome = false;
  final _controllerAmout = TextEditingController();
  final _controllerName = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _newTrasaction() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add new transaction'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const Text('Type: '),
                    DropdownButton<String>(
                      items: const [
                        DropdownMenuItem(value: 'expense', child: Text('Expense')),
                        DropdownMenuItem(value: 'income', child: Text('Income')),
                      ],
                      onChanged: (String? value) {
                        setState(() {
                          _isIncome = value == 'income';
                        });
                      },
                      value: _isIncome ? 'income' : 'expense',
                    ),
                  ],
                ),
                TextFormField(
                  controller: _controllerName,
                  decoration: const InputDecoration(hintText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _controllerAmout,
                  decoration: const InputDecoration(hintText: 'Amount'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an amount';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  GoogleSheetsApi.insertTransaction(_controllerName.text, _controllerAmout.text, _isIncome);
                  setState(() {});
                  _controllerName.clear();
                  _controllerAmout.clear();
                  Navigator.pop(context);
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void startLoading() {
    timeHasStatred = true;
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (GoogleSheetsApi.isLoaded == false) {
        setState(() {
          timeHasStatred = false;
        });
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (GoogleSheetsApi.isLoaded == true && timeHasStatred == false) {
      startLoading();
    }
    return Scaffold(
      backgroundColor: aliasTokens.color.elements.bgColor01,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 72.0),
        child: Column(
          children: [
            TopCard(
              balance: GoogleSheetsApi.calculateDifference().toString(),
              expense: GoogleSheetsApi.calculateExpense().toString(),
              income: GoogleSheetsApi.calculateIncome().toString(),
            ),
            Expanded(
              child: GoogleSheetsApi.isLoaded == true
                  ? Loading()
                  : ListView.builder(
                      itemCount: GoogleSheetsApi.currentTransactions.length,
                      itemBuilder: (context, index) {
                        return Transactions(
                          trnsactionName: GoogleSheetsApi.currentTransactions[index][0],
                          transactionAmount: GoogleSheetsApi.currentTransactions[index][1],
                          expenseOrIncome: GoogleSheetsApi.currentTransactions[index][2],
                          dateTransaction: GoogleSheetsApi.currentTransactions[index][3],
                          transactionType: GoogleSheetsApi.currentTransactions[index][4],
                        );
                      },
                    ),
            ),
            PlusButton(onPressed: _newTrasaction),
          ],
        ),
      ),
    );
  }
}

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(backgroundColor: Colors.transparent),
      ),
    );
  }
}
