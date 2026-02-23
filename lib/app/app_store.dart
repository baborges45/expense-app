import 'package:expense_app/app/commons/commons.dart';
import 'package:expense_app/app/commons/domain/entities/transaction_entity.dart';

class AppStore {
  final _transactions = RxList<TransactionEntity>();

  List<TransactionEntity> get transactions => _transactions;

  set transactions(List<TransactionEntity> value) => _transactions.assignAll(value);

  final _user = Rxn<TransactionEntity>();
  TransactionEntity? get user => _user.value;
  set user(TransactionEntity? value) => _user.value = value;

  bool get authenticated => user != null;
}
