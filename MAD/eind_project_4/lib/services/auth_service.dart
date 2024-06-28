import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final String baseUrl = 'http://127.0.0.1:8000/api';
  final FlutterSecureStorage storage = FlutterSecureStorage();

  Future<void> register(String name, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': password,
      }),
    );

    if (response.statusCode == 201) {
      final jsonResponse = json.decode(response.body);
      await storage.write(key: 'token', value: jsonResponse['token']);
    } else {
      final errorMessage = 'Failed to register: ${response.statusCode} ${response.body}';
      print(errorMessage);
      throw Exception(errorMessage);
    }
  }

  Future<void> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      await storage.write(key: 'token', value: jsonResponse['access_token']);
    } else {
      final errorMessage = 'Failed to login: ${response.statusCode} ${response.body}';
      print(errorMessage);
      throw Exception(errorMessage);
    }
  }

  Future<void> logout() async {
    final token = await storage.read(key: 'token');
    final response = await http.post(
      Uri.parse('$baseUrl/logout'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      await storage.delete(key: 'token');
    } else {
      final errorMessage = 'Failed to logout: ${response.statusCode} ${response.body}';
      print(errorMessage);
      throw Exception(errorMessage);
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await storage.read(key: 'token');
    return token != null;
  }

  Future<String?> getToken() async {
    return await storage.read(key: 'token');
  }
}
