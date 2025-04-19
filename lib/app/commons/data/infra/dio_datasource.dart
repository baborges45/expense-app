import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:expense_app/app/commons/commons.dart';

const env = String.fromEnvironment('env', defaultValue: 'prod');

const defaultHeaders = {
  'contentType': 'application/json',
  'accept': 'application/json',
};

String? _token;

class DioDatasource implements HttpAdapter {
  final Dio _dio = Dio();

  DioDatasource() {
    _dio.options.baseUrl = baseUrl;
  }

  String get baseUrl => env == 'dev' ? 'https://service-dev.mude.health/api' : 'https://service.mude.health/api';

  @override
  Future delete({
    required String url,
    Map<String, dynamic> query = const {},
    Map<String, String> headers = defaultHeaders,
  }) async {
    try {
      final response = await _dio.delete(
        url,
        queryParameters: query,
        options: Options(headers: {
          ...headers,
          if (_token != null) 'Authorization': 'Bearer $_token',
        }),
      );
      return response.data;
    } on Exception catch (_) {
      rethrow;
    }
  }

  @override
  Future get({
    required String url,
    Map<String, dynamic> query = const {},
    Map<String, String> headers = defaultHeaders,
  }) async {
    try {
      final response = await _dio.get(
        url,
        queryParameters: query,
        options: Options(headers: {
          ...headers,
          if (_token != null) 'Authorization': 'Bearer $_token',
        }),
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future patch({
    required String url,
    Map body = const {},
    Map<String, dynamic> query = const {},
    Map<String, String> headers = defaultHeaders,
  }) async {
    try {
      final response = await _dio.patch(
        url,
        queryParameters: query,
        data: json.encode(body),
        options: Options(headers: {
          ...headers,
          if (_token != null) 'Authorization': 'Bearer $_token',
        }),
      );
      return response.data;
    } on Exception catch (_) {
      rethrow;
    }
  }

  @override
  Future post({
    required String url,
    Map body = const {},
    Map<String, dynamic> query = const {},
    Map<String, String> headers = defaultHeaders,
  }) async {
    try {
      final response = await _dio.post(
        url,
        queryParameters: query,
        data: json.encode(body),
        options: Options(headers: {
          ...headers,
          if (_token != null) 'Authorization': 'Bearer $_token',
        }),
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future put({
    required String url,
    required Map body,
    Map<String, dynamic> query = const {},
    Map<String, String> headers = defaultHeaders,
  }) async {
    try {
      final response = await _dio.put(
        url,
        queryParameters: query,
        data: json.encode(body),
        options: Options(headers: {
          ...headers,
          if (_token != null) 'Authorization': 'Bearer $_token',
        }),
      );
      return response.data;
    } on Exception catch (_) {
      rethrow;
    }
  }

  @override
  Future googleSheets({
    required String action,
    required String url,
    Map<String, dynamic> query = const {},
    Map<String, dynamic> data = const {},
    Map<String, String> headers = defaultHeaders,
  }) async {
    try {
      late Response response;

      switch (action) {
        case 'post':
          response = await _dio.post(
            url,
            queryParameters: query,
            data: json.encode(data),
            options: Options(headers: {
              ...headers,
              if (_token != null) 'Authorization': 'Bearer $_token',
            }),
          );
          break;

        case 'put':
          response = await _dio.put(
            url,
            queryParameters: query,
            data: json.encode(data),
            options: Options(headers: {
              ...headers,
              if (_token != null) 'Authorization': 'Bearer $_token',
            }),
          );
          break;

        case 'delete':
          response = await _dio.delete(
            url,
            queryParameters: query,
            options: Options(headers: {
              ...headers,
              if (_token != null) 'Authorization': 'Bearer $_token',
            }),
          );
          break;

        default:
          throw Exception('Ação desconhecida para Google Sheets API');
      }

      return response.data;
    } on DioException catch (e) {
      throw Exception('Erro ao executar ação $action: ${e.response?.data ?? e.message}');
    } catch (e) {
      rethrow;
    }
  }

  @override
  void setAuthorizationToken(String? token) {
    _token = token;
  }
}
