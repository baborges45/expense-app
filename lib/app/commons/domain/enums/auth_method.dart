enum AuthMethod {
  email('email'),
  apple('apple'),
  google('google');

  final String value;
  const AuthMethod(this.value);
}
