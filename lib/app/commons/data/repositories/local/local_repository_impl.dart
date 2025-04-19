import 'package:expense_app/app/commons/commons.dart';

class LocalRepositoryImpl extends LocalRepository {
  final GetStorage storage;

  LocalRepositoryImpl({required this.storage});

  @override
  T? read<T>(String key) {
    return storage.read<T>(key);
  }

  @override
  write<T>(String key, T? value) {
    storage.write(key, value);
  }
}
