import 'package:dio/dio.dart';
import 'dart:convert';
import 'dart:html' as html;
import '../models/followingsModel.dart';

String url = "http://localhost:8000/api/user/suggestion-followings";

class FollowingsService {
  List<FollowingsModel> follow = [];
  static final Dio dio = Dio(); //parameter in followings (String id )
  Future<List<FollowingsModel>> followingsData() async {
    final response = await dio.get(url,
        options: Options(headers: {
          'Content-Type': 'application/json',
        }));

    print('FoolowingsData: ${response.data}');
    if (response.statusCode == 200) {
      response.data.forEach((ele) {
        FollowingsModel follows = FollowingsModel.fromJson(ele);

        print('follows $ele');
        follow.add(follows);
      });
    } else {
      throw Exception('Request failed with status: ${response.statusCode}.');
    }
    return follow;
  }
}
