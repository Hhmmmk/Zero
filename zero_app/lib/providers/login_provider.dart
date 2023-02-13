import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:zero_app/modules/login_res.dart';

class LoginProvider extends ChangeNotifier {
  bool isLoginError = false;
  bool isLoading = false;
  Future<bool> login(String userName, String password) async {
    isLoading = true;
    notifyListeners();
    final response = await http.post(
      Uri.parse('https://reqres.in/api/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': userName,
        'password': password,
      }),
    );
    isLoading = false;
    if (response.statusCode == 200 || response.statusCode == 201) {
      final loginResponse = LoginResponse.fromJson(jsonDecode(response.body));
      isLoginError = false;
      notifyListeners();
      return true;
    } else {
      isLoginError = true;
      notifyListeners();
      return false;
    }
  }
}
