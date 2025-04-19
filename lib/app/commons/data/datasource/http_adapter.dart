abstract class HttpAdapter {
  Future<dynamic> get({
    required String url,
    Map<String, dynamic> query,
    Map<String, String> headers,
  });

  Future<dynamic> post({
    required String url,
    required Map body,
    Map<String, dynamic> query,
    Map<String, String> headers,
  });

  Future<dynamic> put({
    required String url,
    required Map body,
    Map<String, dynamic> query,
    Map<String, String> headers,
  });

  Future<dynamic> patch({
    required String url,
    Map body,
    Map<String, dynamic> query,
    Map<String, String> headers,
  });

  Future<dynamic> delete({
    required String url,
    Map<String, dynamic> query,
    Map<String, String> headers,
  });

  Future<dynamic> googleSheets({
    required String action,
    required String url,
    Map<String, dynamic> query = const {},
    Map<String, dynamic> data = const {},
    Map<String, String> headers,
  });

  void setAuthorizationToken(String? token);
}
