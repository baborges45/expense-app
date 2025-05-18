import 'package:expense_app/app/commons/commons.dart';
import 'package:expense_app/app/modules/chart/presentation/store/chart_store.dart';

class ChartController extends PageLifeCycleController {
  final ApiRepository repository;
  @override
  final ChartStore store;
  final AppStore appStore;

  ChartController({
    required this.repository,
    required this.appStore,
    required this.store,
  });

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  Future<void> getData() async {
    store.loading();
    try {
      store.currentTransactions = appStore.transactions.map((transaction) {
        final Map<String, dynamic> json = transaction.toJson();
        return [
          json['name'] ?? '',
          json['amount'] ?? '',
          json['expenseOrIncome'] ?? '',
          json['date'] ?? '',
          json['transactionType'] ?? '',
        ];
      }).toList();

      store.expenseTransactions = store.currentTransactions.where((transaction) {
        return transaction[2] == 'expense';
      }).toList();

      store.typeTransaction = store.expenseTransactions
          .map((transaction) {
            return transaction[4];
          })
          .toList()
          .join(', ');

      store.completed();
    } catch (e) {
      store.error = e.toString();
      debugPrint(e.toString());
    }
  }

  String getTypeLabel(int typeId) {
    Map<int, String> typeNames = {
      0: 'Alimentação',
      1: 'Transporte',
      2: 'Entretenimento',
      3: 'Educação',
      4: 'Finanças',
      5: 'Compras',
      6: 'Saúde',
      7: 'Casa',
      8: 'Presentes',
      9: 'Renda Extra',
      10: 'Outros',
    };

    return typeNames[typeId] ?? 'Outros';
  }
}
