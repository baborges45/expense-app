// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionEntity _$TransactionEntityFromJson(Map<String, dynamic> json) =>
    TransactionEntity(
      id: json['id'] as String,
      name: json['name'] as String,
      amount: json['amount'] as String,
      date: json['date'] as String,
      expenseOrIncome: json['expense_or_income'] as String,
      transactionType: json['transaction_type'] as String,
    );
