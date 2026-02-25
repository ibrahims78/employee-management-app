import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiClient {
  final Dio dio = Dio();
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final String baseUrl = "http://localhost:5000/api"; // Default for local testing

  ApiClient() {
    dio.options.baseUrl = baseUrl;
    dio.options.connectTimeout = const Duration(seconds: 5);
    dio.options.receiveTimeout = const Duration(seconds: 3);

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        debugPrint('--- REQUEST [${options.method}] ${options.path} ---');
        final token = await storage.read(key: 'jwt_token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
          debugPrint('Token Attached: Yes');
        } else {
          debugPrint('Token Attached: No');
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        debugPrint('--- RESPONSE [${response.statusCode}] ${response.requestOptions.path} ---');
        debugPrint('Payload: ${response.data}');
        return handler.next(response);
      },
      onError: (DioException e, handler) async {
        debugPrint('--- ERROR [${e.response?.statusCode}] ${e.requestOptions.path} ---');
        if (e.response?.statusCode == 401) {
          debugPrint('Unauthorized - Clearing Token');
          await storage.delete(key: 'jwt_token');
          // Navigation handling would typically be done via a global key or listener
        }
        return handler.next(e);
      },
    ));
  }

  Future<Response> login(String username, String password) async {
    print('--- FLUTTER LOGIN REQUEST ---');
    print('Endpoint: /api/mobile/login');
    print('Payload: {username: $username, password: ***}');
    return await dio.post('/mobile/login', data: {
      'username': username,
      'password': password,
    });
  }

  Future<Response> getMe() async {
    return await dio.get('/auth/me');
  }
}

final apiClient = ApiClient();
