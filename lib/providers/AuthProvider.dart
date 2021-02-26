import 'dart:convert';

import 'package:chat_app/globals/enviroment.dart';
import 'package:chat_app/models/LoginResponse.dart';
import 'package:chat_app/models/error_response.dart';
import 'package:chat_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
  User user;
  bool _authenticating = false;
  ErrorResponse errorResponse;

  bool get authenticating => _authenticating;
  final _storage = new FlutterSecureStorage();

  set authenticating(bool value) {
    _authenticating = value;
    notifyListeners();
  }

  static Future<String> getToken() async {
    final _storage = new FlutterSecureStorage();
    return await _storage.read(key: 'token');
  }

  static Future<void> deleteToken() async {
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  Future<bool> register(String name, String email, String password) async {
    errorResponse = ErrorResponse();
    this.authenticating = true;
    final data = {'name': name, 'email': email, 'password': password};

    final resp = await http.post('${Enviroment.apiUrl}/login/new',
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.user = loginResponse.user;
      await this._saveToken(loginResponse.token);
      return true;
    } else {
      errorResponse = errorResponseFromJson(resp.body);
      this.authenticating = false;
      return false;
    }
  }

  Future<bool> login(String email, String password) async {
    this.authenticating = true;
    final data = {'email': email, 'password': password};

    final resp = await http.post('${Enviroment.apiUrl}/login',
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.user = loginResponse.user;
      await this._saveToken(loginResponse.token);
      return true;
    } else {
      this.authenticating = false;
      return false;
    }
  }

  Future _saveToken(String token) async {
    await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    await _storage.delete(key: 'token');
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: 'token');

    final resp = await http.get('${Enviroment.apiUrl}/login/renew',
        headers: {'Content-Type': 'application/json', 'x-token': token});

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.user = loginResponse.user;
      await this._saveToken(loginResponse.token);
      print(loginResponse.token);
      return true;
    } else {
      this.logout();
      return false;
    }
  }
}
