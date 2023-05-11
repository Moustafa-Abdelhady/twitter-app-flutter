import 'package:dio/dio.dart';
import 'dart:convert';
import 'dart:html' as html;
import '../models/postsModel.dart';

String Url = "http://localhost:8000/api/tweet";

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

class PostService {
  Future<List<PostModel>> postData() async {
    final cookie = getCookie('acessToken');
    String? access_token = cookie;

    // String postLink = 'tweet';

    List<PostModel> post = [];
    final dio = Dio();

    try {
      final response = await dio.get('${Url}',
          options: Options(headers: {
            'Content-Type': 'application/json',
          }),
          queryParameters: ({
            
            'access_token': access_token,
            'client_id': 'pYCSiQllhFFivVInLE7Y4DHEdYSqkGgG3jJMxcQd'
          }));
      print('response.data ${response.data}');
      if (response.statusCode == 200) {
        response.data.forEach((ele) {
          PostModel posts = PostModel.fromJson(ele);

          print('postEle $ele');

          print('posts $posts');
          post.add(posts);
         
        });
      } 
    } catch (e, stackTrace) {
      if (e is RangeError) {
        print('RangeError');
      } else {
        print(e);
      }
    }
     return post;
  }
}
