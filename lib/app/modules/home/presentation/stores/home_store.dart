import 'package:expense_app/app/commons/commons.dart';

class HomeStore extends StateStore {
  RxBool timeHasStarted = false.obs;

  RxBool isEditing = false.obs;
  RxInt? editingIndex;

  final _isIncome = false.obs;
  bool get isIncome => _isIncome.value;
  set isIncome(bool value) => _isIncome.value = value;

  final _expenseOrIncome = ''.obs;
  String get expenseOrIncome => _expenseOrIncome.value;
  set expenseOrIncome(String value) => _expenseOrIncome.value = value;

  final _selectedType = Rxn<ExpenseDropdownItem>();
  ExpenseDropdownItem? get selectedType => _selectedType.value;
  set selectedType(ExpenseDropdownItem? value) => _selectedType.value = value;

  final types = RxList<ExpenseDropdownItem>();
  final typesList = RxList<int>();

  int numberOfTransactions = 0;

  final _currentTransactions = RxList<List<dynamic>>([]);
  List<List<dynamic>> get currentTransactions => _currentTransactions;
  RxList<List<dynamic>> get currentTransactionsRx => _currentTransactions;
  set currentTransactions(List<List<dynamic>> value) => _currentTransactions.value = value;
  bool isLoaded = true;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController transactionTypeController = TextEditingController();

  final TextEditingController createNameController = TextEditingController();
  final TextEditingController createAmountController = TextEditingController();
  final TextEditingController editNameController = TextEditingController();
  final TextEditingController editAmountController = TextEditingController();

  final _amount = ''.obs;
  String get amount => _amount.value;
  RxString get amountRx => _amount;
  set amount(String value) => _amount.value = value;

  final _amountError = false.obs;
  bool get amountError => _amountError.value;
  set amountError(bool value) => _amountError.value = value;

  final _name = ''.obs;
  String get name => _name.value;
  RxString get nameRx => _name;
  set name(String value) => _name.value = value;

  final _nameError = false.obs;
  bool get nameError => _nameError.value;
  set nameError(bool value) => _nameError.value = value;

  final _balance = 0.0.obs;
  double get balance => _balance.value;
  RxDouble get balanceRx => _balance;
  set balance(double value) => _balance.value = value;

  final date = RxList<DateTime>([]);

  final _dateError = false.obs;
  bool get dateError => _dateError.value;
  set dateError(bool value) => _dateError.value = value;

  final _transactionType = ''.obs;
  String get transactionType => _transactionType.value;
  RxString get transactionTypeRx => _transactionType;
  set transactionType(String value) => _transactionType.value = value;

  final _transactionTypeError = false.obs;
  bool get transactionTypeError => _transactionTypeError.value;
  set transactionTypeError(bool value) => _transactionTypeError.value = value;
}
