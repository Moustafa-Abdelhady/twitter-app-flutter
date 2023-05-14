import 'package:dio/dio.dart';
import 'dart:convert';
import 'dart:html' as html;
import '../models/userModel.dart';

String Url = "http://localhost:8000/api/user/profile/";

String? getCookie(String key) {
  final cookies = html.document.cookie!.split(';');
  for (var cookie in cookies) {
    final keyValue = cookie.split('=');
    if (keyValue[0].trim() == key) {
      return keyValue[1];
    }
  }
  return null;
}

class UserService {
  UserModel? user;
  // Map<String,dynamic>? user;
  // final dio = Dio();
  //add static try
  static final Dio _dio = Dio();
  static Future<UserModel?> userData() async {
    final cookie = getCookie('acessToken');
    final usercookie = getCookie('username');
    String? token = cookie;
    String? username = usercookie;
    print('UU${username}');
    print('token $token');

    final response = await _dio.get('${Url}${username}',
        options: Options(headers: {
          'Content-Type': 'application/json',
        }),
        queryParameters: ({
          'access_token': token,
          'client_id': 'pYCSiQllhFFivVInLE7Y4DHEdYSqkGgG3jJMxcQd'
        }));
    print('UserData ${response.data}');
    if (response.statusCode == 200 && response.data != Null) {
      print('good o');
      // response.data.forEach((ele) {/
      // UserModel users = UserModel.fromJson((ele));
      // user!.add(users);
      // });

      UserModel? users = UserModel.fromJson(response.data);
      print('UserModel $users');
      return users;
      // final UserModel? user = UserModel.fromJson(jsonDecode(response.data));

      // return user;
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}
