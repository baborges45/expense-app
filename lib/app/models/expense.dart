import 'package:isar/isar.dart';

part 'expense.g.dart';

@Collection()
class Expense {
  Id id = Isar.autoIncrement;
  final String name;
  final double amount;
  final bool isIncome;
  final DateTime date;

  Expense({
    required this.name,
    required this.amount,
    required this.isIncome,
    required this.date,
  });
}
