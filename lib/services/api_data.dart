import 'package:dio/dio.dart';
import 'dart:convert';
import '../models/apiModel.dart';

class ApiData {
  final Flutter_App_Base_url = "http://localhost:8000/";
  final Endpoint = 'auth/token';

  Future<ApiModel> getApiData({
    String? client_id,
    String? client_secret,
    String? grant_type,
    String? username,
    String? password,
  }) async {
    final url = Flutter_App_Base_url + Endpoint;

    final data = {
      'client_id': client_id,
      'client_secret': client_secret,
      'grant_type': grant_type,
      'username': username,
      'password': password,
    };

    final options = Options(
      contentType: 'application/json',
    );

    final response =
        await Dio().post(url, options: options, data: jsonEncode(data));
        

    if (response.statusCode == 200) {
      
      final token = ApiModel.fromJson(response.data);
      print('good lol');
      return token;
    } else {
      throw Exception('Request failed with status: ${response.statusCode}.');
    }
  }
}
