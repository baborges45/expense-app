import 'package:expense_app/app/commons/commons.dart';

abstract class ApiRepository {
  // Auth
  // Future<UserEntity> fetchUser([String? token]);

  // Future<bool> sendValidationCode(String email);

  // Future<bool> sendValidationCodeForNewUser(String email);

  // Future<UserEntity> validateCode(String email, String code);

  // Future<UserEntity> socialLoginAuth(String token);

  // Future<UserEntity> updateUserProfile(UserFormEntity form, int userId);

  // // Onboarding
  // Future<List<TagEntity>> fetchTags();

  // Future<void> updateTagProfile(List<int?> tagIds);

  // Google Sheets API
  Future<void> initGoogleSheets();
  Future<void> addTransaction(String name, String amount, bool isIncome);
  Future<void> deleteTransaction(int index);
  Future<void> updateTransaction(int index, String name, String amount, bool isIncome);
  //Future<int> countRows();
  Future<List<List<dynamic>>> getAllTransactions();
  Worksheet? getWorksheet();
  Future<void> insertTransaction(String name, String amount, bool isIncome, String date, String transactionType);
}
