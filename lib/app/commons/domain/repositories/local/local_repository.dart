abstract class LocalRepository {
  write<T>(String key, T? value);
  T? read<T>(String key);
}
