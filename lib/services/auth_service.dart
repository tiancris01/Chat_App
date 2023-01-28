import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:offertorio/global/env.dart';

import 'package:offertorio/models/login_response.dart';
import 'package:offertorio/models/usuarios.dart';

class AuthService with ChangeNotifier {
  late Usuario usuario;
  bool _autenticando = false;

  final _storage = new FlutterSecureStorage();

  bool get autenticando => this._autenticando;
  set autenticando(bool valor) {
    this._autenticando = valor;
    notifyListeners();
  }

  static Future<String?> getToken() async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }

  static Future<void> deletToken() async {
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  Future<bool> login(String email, String contrasena) async {
    this.autenticando = true;

    final data = {'email': email, 'contraseña': contrasena};

    final uri = Uri.parse('${Env.apiUrl}/login');
    final resp = await http.post(
      uri,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );

    this.autenticando = false;

    if (resp.statusCode == 200) {
      final loginresponse = loginResponseFromJson(resp.body);
      this.usuario = loginresponse.usuario;
      await this._guardarToken(loginresponse.token);
      return true;
    } else {
      return false;
    }
  }

  Future register(String nombre, String email, String contrasena) async {
    this.autenticando = true;

    final data = {'nombre': nombre, 'email': email, 'contraseña': contrasena};

    final uri = Uri.parse('${Env.apiUrl}/login/new');
    final resp = await http.post(uri,
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    this.autenticando = false;

    if (resp.statusCode == 200) {
      final loginresponse = loginResponseFromJson(resp.body);
      this.usuario = loginresponse.usuario;
      await this._guardarToken(loginresponse.token);
      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: 'token');
    final uri = Uri.parse('${Env.apiUrl}/login/renew');
    final resp = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'x-token': token.toString()
    });

    if (resp.statusCode == 200) {
      final loginresponse = loginResponseFromJson(resp.body);
      this.usuario = loginresponse.usuario;
      await this._guardarToken(loginresponse.token);

      return true;
    } else {
      this.logout();
      return false;
    }
  }

  Future _guardarToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    await _storage.delete(key: 'token');
  }
}
