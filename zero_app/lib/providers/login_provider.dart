import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:zero_app/modules/login_res.dart';

class LoginProvider extends ChangeNotifier {
  Future<bool> login(String userName, String password) async {
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
    if (response.statusCode == 200 || response.statusCode == 201) {
      final loginResponse =  LoginResponse.fromJson(jsonDecode(response.body));
      // save token to secure storage
      return true;
    } else {
      return false;
    }
  }
}