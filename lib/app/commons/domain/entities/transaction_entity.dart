import 'package:json_annotation/json_annotation.dart';

part 'transaction_entity.g.dart';

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class TransactionEntity {
  final String id;
  final String name;
  final String amount;
  final String date;
  final String expenseOrIncome;
  final String transactionType;

  TransactionEntity({
    required this.id,
    required this.name,
    required this.amount,
    required this.date,
    required this.expenseOrIncome,
    required this.transactionType,
  });

  @override
  String toString() {
    return 'TransactionEntity{id: $id, name: $name, amount: $amount, date: $date, expenseOrIncome: $expenseOrIncome, transactionType: $transactionType}';
  }

  factory TransactionEntity.fromJson(Map<String, dynamic> json) => _$TransactionEntityFromJson(json);

  toJson() {
    return {
      'id': id,
      'name': name,
      'amount': amount,
      'date': date,
      'expenseOrIncome': expenseOrIncome,
      'transactionType': transactionType,
    };
  }

  factory TransactionEntity.fromMap(Map<String, dynamic> map) {
    return TransactionEntity(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      amount: map['amount'] ?? '',
      date: map['date'] ?? '',
      expenseOrIncome: map['expenseOrIncome'] ?? '',
      transactionType: map['transactionType'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'amount': amount,
      'date': date,
      'expenseOrIncome': expenseOrIncome,
      'transactionType': transactionType,
    };
  }
}
