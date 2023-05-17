import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dio/dio.dart';
import 'dart:html' as html;
import '../../models/userModel.dart';
import '../../services/user_data.dart';
import '../../models/followingsModel.dart';
import '../../services/followings_data.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Searchpage extends StatefulWidget {
  const Searchpage({Key? key}) : super(key: key);

  @override
  _SearchpageState createState() => _SearchpageState();
}

class _SearchpageState extends State<Searchpage> {
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

  final TextEditingController _searchController = TextEditingController();

  final FollowingsService _followingsService = FollowingsService();
  List<FollowingsModel> _follow = [];

  final UserService _userService = UserService();
  UserModel? _user;
  UserModel? userI;
  static final Dio _dio = Dio();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFollowingsData();
    getUserData();
    // _postList = PostService().postData();
    // getSearchData();
  }

  String searchValue = '';

  @override
  void dispose() {
    _searchController.dispose();
    print('##${_searchController.text}');

    super.dispose();
  }

  Future<dynamic> getUserData() async {
    print('getUserData Calld');

    final UserModel? user = await UserService.userData();
    print('users counter: ${user}');
    if (user != null) {
      setState(() {
        userI = user;
        print('oo${userI}');
      });
    }
  }

  Future<dynamic> getFollowingsData() async {
    print('getFollowingsData in profile page Calld');
    final follow = await _followingsService.followingsData();
    print('follow counter ${follow.length}');
    if (follow.length != null) {
      setState(() {
        _follow = follow;
      });
    }
  }

  // Future<dynamic> getSearchData() async {
  //   final cookie = getCookie('acessToken');
  //   print('getUserData in profile page Calld');

  //   final response = await _dio.get(
  //       'http://localhost:8000/api/user/profile/${_searchController.text}',
  //       options: Options(headers: {
  //         'Content-Type': 'application/json',
  //       }),
  //       queryParameters: ({
  //         'access_token': cookie,
  //         'client_id': 'pYCSiQllhFFivVInLE7Y4DHEdYSqkGgG3jJMxcQd'
  //       }));
  //   print('Search Data: ${response.data}');
  //   if (response.statusCode == 200 && response.data != null) {
  //     setState(() {
  //       _user = UserModel.fromJson(response.data);
  //       print('>>${_user}');
  //     });
  //   } else {
  //     throw Exception('Failed to fetch Search data');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.blue,
          child: const Icon(
            Icons.add,
            size: 30,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 15, right: 15, top: 20),
            child: Stack(
              children: [
                SafeArea(
                  top: false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           (userI?.profile?.image != null)?
                            CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage('http://localhost:8000/api${userI?.profile?.image}'),
                          ) : CircleAvatar(
                                                  child: Icon(Icons.person),
                                                  // radius: 50,
                                                ),
                          SizedBox(
                            height: 40,
                            width: 300,
                            child: TextField(
                              controller: _searchController,
                              obscureText: false,
                              onChanged: (value) async {
                                setState(() {
                                  searchValue = value;
                                });
                                print('searchValue: $searchValue');
                                final cookie = getCookie('acessToken');
                                print('getUserData in profile page Calld');

                                final response = await _dio.get(
                                    'http://localhost:8000/api/user/profile/${_searchController.text}',
                                    options: Options(headers: {
                                      'Content-Type': 'application/json',
                                    }),
                                    queryParameters: ({
                                      'access_token': cookie,
                                      'client_id':
                                          'pYCSiQllhFFivVInLE7Y4DHEdYSqkGgG3jJMxcQd'
                                    }));
                                print('Search Data: ${response.data}');
                                if (response.statusCode == 200 &&
                                    response.data != null) {
                                  setState(() {
                                    _user = UserModel.fromJson(response.data);
                                    print('>>${_user}');
                                  });
                                } else {
                                  throw Exception(
                                      'Failed to fetch Search data');
                                }
                              },
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(30)),
                                  hintText: 'Search Twitter',
                                  filled: true,
                                  fillColor: Colors.grey[300]),
                            ),
                          ),
                          const Icon(
                            FontAwesomeIcons.gear,
                            color: Colors.black,
                            size: 27,
                          )
                        ],
                      ),
                      const Divider(
                        thickness: 1.5,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Center(
                        child: card(_user, searchValue, _dio),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
// Center(
//   child: card(_user, searchValue, _dio) != ''
//       ? Divider(
//           thickness: 1.5,
//         )
//       : Divider(
//           thickness: 0,
//         ),
// ),
                      const SizedBox(
                        height: 7,
                      ),
                      SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: [
                              // followings(_follow, _dio)

                              Container(
                                height: 440,
                                width: 450,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  // border: Border.all(
                                  //   color: Colors.grey,
                                  //   width: 0.6,
                                  // ),
                                ),
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [followings(_follow, _dio)]),
                              ),
                            ],
                          )),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  String? userFollow;
  Widget card(
    UserModel? _user,
    searchValue,
    _dio,
  ) {
    return (_user != null)
        ? Card(
            child: Padding(
              padding: EdgeInsets.all(35.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  (_user?.profile?.image != null)
                      ? CircleAvatar(
                          radius:
                              30, // You can adjust the radius as per your needs
                          child: ClipOval(
                              child: (_user?.profile?.image != null)
                                  ? Image.network(
                                      'http://localhost:8000/api${_user?.profile?.image}',
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit
                                          .cover, // This property ensures that the image fills the circular avatar without stretching or distorting it
                                    )
                                  : Icon(Icons.person_2_outlined)),
                        )
                      : Icon(Icons.person_2_rounded),
                  SizedBox(width: 15.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${_user?.fullname}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text('@${_user?.username}'),
                      ],
                    ),
                  ),
                  SizedBox(width: 15.0),
                  InkWell(
                    onTap: () async {
                      final cookie = getCookie('acessToken');
                      // Add your button action here
                      final response = await _dio.put(
                          'http://localhost:8000/api/user/follow/${searchValue}',
                          options: Options(headers: {
                            'Content-Type': 'application/json',
                            'Authorization': 'Bearer $cookie'
                          }),
                          data: ({
                            'client_id':
                                'pYCSiQllhFFivVInLE7Y4DHEdYSqkGgG3jJMxcQd'
                          }));

                      final Map<String, dynamic> responseBody = response.data;
                      // final responseTojson = json.encode(response);
                      // final responseBody = json.decode(responseTojson);
                      final String state = responseBody['state'];

                      setState(() {
                        userFollow = state;
                      });
                      // userFollow = state;

                      // print('follow:${responseTojson}');
                      print('follow:${response}');
                      print('follows:${userFollow}');
                      print('folcookie:$cookie');
                    },
                    child: Container(
                      height: 30,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                          child:
                              //  (userFollow != 'unfollow')?
                              Text(
                        (userFollow == 'unfollow') ? 'follow' : 'unfollow',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )
                          // : Text(
                          //     'unFollow',
                          //     style: TextStyle(
                          //       color: Colors.white,
                          //     ),
                          //   ),
                          ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : Card();
  }

  // List usersFollow = [];

  Widget followings(List<FollowingsModel> _follow, _dio) {
    return Expanded(
        child: ListView.builder(
      itemCount: _follow.length,
      itemBuilder: (context, index) {
        final follow = _follow[index];
        bool isFollowing = false;
        return (follow != null)
            ? Card(
                child: Padding(
                  padding: EdgeInsets.all(40.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      (_follow[index] != null)
                          ? CircleAvatar(
                              radius:
                                  30, // You can adjust the radius as per your needs
                              child: ClipOval(
                                  child: (follow.image != '')
                                      ? Image.network(
                                          'http://localhost:8000/api${follow.image}',
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit
                                              .cover, // This property ensures that the image fills the circular avatar without stretching or distorting it
                                        )
                                      : Icon(Icons.person_2_rounded)),
                            )
                          : Icon(Icons.person_2_rounded),
                      SizedBox(width: 15.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${follow?.fullname}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Text('@${follow?.username}'),
                          ],
                        ),
                      ),
                      SizedBox(width: 10.0),

                      FollowButton(
                        follow: follow,
                        dio: _dio,
                      ),
                      // InkWell(
                      //   onTap: () async {
                      //     final cookie = getCookie('acessToken');
                      //     final username = getCookie('username');
                      //     // Add your button action here
                      //     final response = await _dio.put(
                      //         'http://localhost:8000/api/user/follow/${username}',
                      //         options: Options(headers: {
                      //           'Content-Type': 'application/json',
                      //           'Authorization': 'Bearer $cookie'
                      //         }),
                      //         data: ({
                      //           'client_id':
                      //               'pYCSiQllhFFivVInLE7Y4DHEdYSqkGgG3jJMxcQd'
                      //         }));
                      //     final Map<String, dynamic> responseBody =
                      //         response.data;
                      //     // final responseTojson = json.encode(response);
                      //     // final responseBody = json.decode(responseTojson);
                      //     final String state = responseBody['state'];
                      //     // final List state = responseBody['state'];

                      //     // onPressed:
                      //     // () {
                      //     setState(() {
                      //       isFollowing = state == 'follow';
                      //       isFollowing;
                      //     });
                      //     // };
                      //     print('follow1:${response}');
                      //     print('isFollowing: $isFollowing');
                      //     print('follow3:${state}');
                      //     print('folcookie:$cookie');
                      //   },
                      //   child: Container(
                      //     height: 30,
                      //     width: 100,
                      //     decoration: BoxDecoration(
                      //       color: Colors.black,
                      //       borderRadius: BorderRadius.circular(15),
                      //     ),
                      //     child: Center(
                      //         child:
                      //             StatefulBuilder(
                      //       builder: (BuildContext context, StateSetter setState) {
                      //         return Text(
                      //           isFollowing ? 'Unfollow' : 'Follow',
                      //           style: TextStyle(
                      //             color: Colors.white,
                      //           ),
                      //         );
                      //       },
                      //     ),
                      //         ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              )
            : Card();
      },
    ));
  }
}

class FollowButton extends StatefulWidget {
  final FollowingsModel follow;
  final dio;

  const FollowButton({required this.follow, required this.dio});

  @override
  _FollowButtonState createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton> {
//  late bool? isFollowing ;
  String? usersFollow;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final cookie = getCookie('acessToken');
        final username = getCookie('username');
        final response = await widget.dio.put(
          'http://localhost:8000/api/user/follow/$username',
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $cookie',
            },
          ),
          data: {
            'client_id': 'pYCSiQllhFFivVInLE7Y4DHEdYSqkGgG3jJMxcQd',
          },
        );

        final Map<String, dynamic> responseBody = response.data;
        final String state = responseBody['state'];

        setState(() {
          usersFollow = state;
        });

        print('follow1: $response');
        // print('isFollowing: $isFollowing');
        print('follow3: $state');
        print('folcookie: $cookie');
      },
      child: Container(
        height: 30,
        width: 100,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(15),
        ), // Button container details
        child: Center(
          child: Text(
            (usersFollow == 'unfollow') ? 'Follow' : 'unFollow',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
