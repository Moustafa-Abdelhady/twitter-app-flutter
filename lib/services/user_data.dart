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
  Future<UserModel?> userData() async {
    final cookie = getCookie('acessToken');
    final usercookie = getCookie('username');
    String? token = cookie;
    String? username = usercookie;
    print('UU${username}');

    UserModel? user;

    final dio = Dio();

    try {
      final response = await dio.get('${Url}${username}',
          options: Options(headers: {
            'Content-Type': 'application/json',
          }),
          queryParameters: ({
            'access_token': token,
            'client_id': 'pYCSiQllhFFivVInLE7Y4DHEdYSqkGgG3jJMxcQd'
          }));
      print('UserData ${response.data}');
      if (response.statusCode == 200 && response.data != 0) {
        print('good o');

        // user = UserModel.fromJson(response.data);

        print('users $user');
         return response.data;
      }
    } catch (e, stackTrace) {
      if (e is RangeError) {
        print('RangeError');
      } else {
        print(e);
      }
    }

   
  }
}
