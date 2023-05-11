import 'package:dio/dio.dart';
import 'dart:convert';

import '../models/registerModel.dart';

class RegisterData {
  final Flutter_App_Base_url = "http://localhost:8000/";
  final Endpoint = 'api/user/register';

  Future<RegisterModel> postRegisterData({
    String? fullname,
    String? username,
    String? email,
    String? birthdate,
    String? password,
  }) async {
    final url = Flutter_App_Base_url + Endpoint;

    final data = {
      'fullname': fullname,
      'username': username,
      'email': email,
      'birthdate': birthdate,
      'password': password,
    };

    final options = Options(
      contentType: 'application/json',
    );

    final response =
        await Dio().post(url, options: options, data: jsonEncode(data));
    print(response.data);
    if (response.statusCode == 200) {
      final token = RegisterModel.fromJson(response.data);
      print(token);
      print('good register lol');
      return token;
    } else {
      throw Exception('Request failed with status: ${response.statusCode}.');
    }
  }
}
