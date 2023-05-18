import 'package:flutter/material.dart';
// import 'dart:convert' as convert;
// import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone/views/pages/profilepage.dart';
// import 'package:twitter_clone/views/pages/loginpage.dart';
import 'package:twitter_clone/views/pages/newTweet.dart';
import 'package:twitter_clone/main.dart';
import 'dart:html' as html;
import 'package:dio/dio.dart';
import '../../models/postsModel.dart';
import '../../services/post_data.dart';
import '../../models/userModel.dart';
import '../../services/user_data.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomepageState createState() => _HomepageState();
}

void setCookie(String key, String value) {
  html.document.cookie = '$key=$value; path=/';
}

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

void deleteCookie(String key) {
  html.document.cookie =
      '$key=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;';
}

class _HomepageState extends State<Homepage> {
  ///posts
  final PostService _postService = PostService();
  List<PostModel> _post = [];

  //users
  final UserService _userService = UserService();
  UserModel? _user;
  // Map<String, dynamic> ?_user;
  //  List<UserModel> _user = [];

  // final Map<String, dynamic> _user;

  // late Future<List<PostModel>> _postList;
  bool? loaded;
  bool ischangecolor = false;
  String? userLike;

  final cookie = getCookie('acessToken');
  // final id = getCookie('userid');
  final username = getCookie('username');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _postList = PostService().postData();
    getUserData();
    getAllPostsData();
    loaded = true;
  }

  Future<dynamic> getAllPostsData() async {
    print('getAllPostsData Calld');
    loaded = true;
    final posts = await _postService.postData();
    print('posts count: ${posts.length}');
    if (posts.isNotEmpty) {
      setState(() {
        _post = posts;
        ischangecolor = !ischangecolor;
        print('loool$_post');
        loaded = false;
      });
    }
  }

  Future<dynamic> getUserData() async {
    print('getUserData Calld');

    final UserModel? user = await UserService.userData();
    print('users counter: ${user}');
    if (user != null) {
      setState(() {
        _user = user;
        print('oo${_user}');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return (loaded != true)
        ? Scaffold(
            // appBar: AppBar(),
            drawer: Drawer(
                backgroundColor: Colors.white,
                child: Column(
                  children: [
                    (_user != null)
                        ?
                        // Expanded(
                        // child:  ListView.separated(

                        // itemCount: _post.length,
                        // itemBuilder: (context, index) {
                        // final post = _post[index];
                        // return
                        Column(
                            children: [
                              // for (int i = 0; i < _user.length; i)

                              (_user != null)
                                  ? UserAccountsDrawerHeader(
                                      currentAccountPictureSize:
                                          Size.fromRadius(30),
                                      decoration:
                                          BoxDecoration(color: Colors.white),
                                      currentAccountPicture:
                                          (_user?.profile?.image != null)
                                              ? ClipOval(
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        'http://localhost:8000/api${_user?.profile?.image}',
                                                    placeholder: (context,
                                                            url) =>
                                                        CircularProgressIndicator(),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Icon(Icons.error),
                                                    fit: BoxFit.cover,
                                                    width: 100,
                                                    height: 100,
                                                  ),
                                                )
                                              : CircleAvatar(
                                                  child: Icon(Icons.person),
                                                  radius: 50,
                                                ),

                                      //  (_user!.fullname != null)?
                                      accountName: Text(
                                        '${_user!.fullname}',
                                        // 'oo',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      // : Text('mostafa'),
                                      accountEmail: Text(
                                        '@${_user!.username}',
                                        // 'al',
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 143, 141, 141),
                                        ),
                                      ),
                                    )
                                  : Text('null'),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      right: 15, left: 15),
                                  child: Row(
                                    children: [
                                      (_user?.following?.length != null)
                                          ? Text(
                                              '${_user?.following?.length}',
                                              // '0',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          : Text('0 '),
                                      Text(
                                        'Following',
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 143, 141, 141),
                                            fontSize: 13),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      (_user?.followers?.length != null)
                                          ? Text(
                                              '${_user?.followers?.length}',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          : Text(' 0 '),
                                      Text(
                                        'Followers',
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 143, 141, 141),
                                            fontSize: 13),
                                      )
                                    ],
                                  )),
                              ListTile(
                                leading: Icon(
                                  Icons.person,
                                  color: Colors.black,
                                ),
                                title: Text('Profile',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600)),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Profilepage()));
                                },
                              ),
                              ListTile(
                                leading: Icon(
                                  Icons.line_style_outlined,
                                  color: Colors.black,
                                ),
                                title: Text(
                                  'Topics',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                onTap: () {},
                              ),
                              ListTile(
                                leading: Icon(
                                  Icons.list_alt_sharp,
                                  color: Colors.black,
                                ),
                                title: Text(
                                  'List',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                onTap: () {},
                              ),
                              ListTile(
                                leading: Icon(
                                  Icons.bookmark,
                                  color: Colors.black,
                                ),
                                title: Text(
                                  'Bookmark',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                onTap: () {},
                              ),
                            ],
                          )
                        : Center(child: CircularProgressIndicator())
                    // }))
                  ],
                )),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                setCookie('userid', _user!.id.toString());
                final id = getCookie('userid');
                print('iid :$id');
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => NewTweet()));
              },
              backgroundColor: Colors.blue,
              child: const Icon(
                FontAwesomeIcons.featherPointed,
                size: 30,
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
                child: Stack(
                  children: [
                    SafeArea(
                        top: false,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Builder(builder: (context) {
                                  return InkWell(
                                    onTap: () {
                                      Scaffold.of(context).openDrawer();
                                    },
                                    child: (_user?.profile?.image != null)
                                        ? CircleAvatar(
                                            radius: 20,
                                            backgroundImage: NetworkImage(
                                                'http://localhost:8000/api${_user?.profile?.image}'),
                                          )
                                        : CircleAvatar(
                                            child: Icon(Icons.person),
                                            backgroundColor: Colors.blue,
                                            //  borderColor: Colors.white,
                                            //   borderWidth: 2,
                                            radius: 20,
                                          ),
                                  );
                                }),
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/twitterlogo.png'))),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    final dio = Dio();
                                    // Add your button press logic here

                                    print(cookie);
                                    print('lool');
                                    // print('iid :$id');
                                    deleteCookie('acessToken');
                                    deleteCookie('userid');
                                    deleteCookie('username');

                                    print('loool');
                                    Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                        return MyApp();
                                      }),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Text('Logout'),
                                ),
                                // const Icon(
                                //   Icons.amp_stories_rounded,
                                //   color: Colors.black,
                                //   size: 32,
                                // )
                              ],
                            ),
                            const Divider(
                              thickness: 1.5,
                            ),
                            // const SizedBox(
                            //   height: 2,
                            // ),
                            Column(
                              //من اول هنا
                              children: [
                                // if (_post.length != null && _post.isNotEmpty)
                                // Expanded(
                                //  ListView.builder(
                                //   itemCount: _post.length,
                                //   itemBuilder: (context, index) {
                                //  print('@@@ :${_post.length}');
                                //   final post = _post[index];
                                for (int i = 0; i < _post.length; i++)

                                  // return
                                  // (_post[i].media.length > 0) ?
                                  SizedBox(
                                      // height: MediaQuery.of(context)
                                      //         .size
                                      //         .height *
                                      //     0.6,
                                      child: PostBodyBuilder(i))
                                // : SizedBox(
                                //     height: MediaQuery.of(context)
                                //             .size
                                //             .height *
                                //         0.3,
                                //     child: PostBodyBuilder(i))
                              ],
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            ),
          )
        : const Center(child: CircularProgressIndicator());
  }

  Widget PostBodyBuilder(int i) {
    // (_post[i].media.length > 0)?
    return Card(
      margin: EdgeInsets.only(bottom: 16.0),
      child: InkWell(
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) =>
          //         PostDetailScreen(
          //             post: post),
          //   ),
          // );
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // if (_post.length != null &&
              //     _post.isNotEmpty)
              Stack(
                children: [
                  // if (_post.length != null && _post.isNotEmpty)

                  Row(
                    children: [
                      // for (int i =
                      //         _post.length - 1;
                      //     i < _post.length;
                      //     i++)
                      if (_post[i].user.image != null)
                        Positioned(
                          top: 0,
                          left: 0,
                          child: ClipOval(
                            child: CachedNetworkImage(
                              imageUrl:
                                  'http://localhost:8000/api${_post[i].user.image}',
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                              fit: BoxFit.cover,
                              width: 70,
                              height: 70,
                            ),
                          ),
                        ),

                      SizedBox(width: 25),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // for (int i = 0; i > _post.length;  i++)
                          Text(
                            '${_post[i].user.fullname}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '@${_post[i].user.username}',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.blueGrey,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Posted on ${(_post[i].createAt)}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding:
                        // (_post[i].media.length >0) ?
                        EdgeInsets.only(top: 100),
                    //: EdgeInsets.only(
                    // top: 130),
                    child: Text(
                      _post[i].content,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 7),
              //  (_post[i].media.length > 0) ?
              if (_post[i].media.length > 0)
                Center(
                    child: SizedBox(
                  height: 200.0,
                  child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context)
                        .copyWith(scrollbars: false),
                    child: ListView.builder(
                      // scrollDirection: Axis.horizontal,
                      itemCount:
                          //  _post.length,
                          _post[i].media.length,
                      itemBuilder: (context, index) {
                        final post = _post[index].media;
                        bool ischangecolor = false;
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          child: AspectRatio(
                              aspectRatio: 20 / 10,
                              // if (post.user.image != null)
                              child: CachedNetworkImage(
                                imageUrl:
                                    'http://localhost:8000/api${_post[i].media[index]['file']}',
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                                fit: BoxFit.cover,
                                width: 100,
                                height: 100,
                              )),
                        );
                      },
                    ),
                  ),
                )),
              // :Center(),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                      final dio = Dio();
                      final cookie = getCookie('acessToken');
                      final id = _post[i].id; // Remove unnecessary curly braces
                      print(id);

                      try {
                        final response = await dio.put(
                          'http://localhost:8000/api/tweet/like/${id}',
                          options: Options(
                            headers: {
                              'Content-Type': 'application/json',
                              'Authorization': 'Bearer $cookie',
                            },
                          ),
                          data: {
                            'client_id':
                                'pYCSiQllhFFivVInLE7Y4DHEdYSqkGgG3jJMxcQd',
                          },
                        );

                        final Map<String, dynamic> responseBody = response.data;
                        final String state = responseBody['state'];

                        setState(() {
                          userLike = state;
                        });

                        print('follow1: $response');
                        print('Following: $userLike');
                        // print('follow3: $state');
                        print('cookie: $cookie');
                      } catch (error) {
                        print('Error: $error');
                      }
                    },
                    child: Icon(
                      Icons.favorite,
                      color: (userLike == 'dislike') ? Colors.red : Colors.grey,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    '${(userLike == 'dislike') ? _post[i].likes.count-- : _post[i].likes.count++}',
                  ),
                  SizedBox(width: 90),
                  InkWell(
                      onTap: () {
                        // setState(() {
                        //   ischangecolor =
                        //       !ischangecolor;
                        // });
                      },
                      child: Icon(Icons.comment, color: Colors.blue)),
                  SizedBox(width: 8),
                  // for (int i = 0;
                  //     i > _post.length;
                  //     i++)
                  Text('${_post[i].comments.count}'),
                  SizedBox(width: 90),
                  InkWell(
                      onTap: () {
                        //  setState(() {
                        // ischangecolor = !ischangecolor;
                        // });
                      },
                      child: Icon(Icons.reply, color: Colors.green)),
                  SizedBox(width: 8),
                  // for (int i = 0;
                  //     i > _post.length;
                  //     i++)
                  Text('${_post[i].replies.count}'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
//     ):Container(
//       // height:450,
//       transform: Matrix4.translationValues(10.0, -50.0, 50.0),
//     // padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//       child: Card(
//         // shape: RoundedRectangleBorder(
//         //   borderRadius:
//         //       BorderRadius.circular(5.0),
//         //   side: BorderSide(
//         //       color: Colors.grey.shade300),
//         // ),
//         margin: EdgeInsets.symmetric(
//             vertical: 90.0, horizontal: 0.0),
//         child: InkWell(

//           child:Padding(
//             padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // if (_post.length != null &&
//                 //     _post.isNotEmpty)
//                 Stack(
//                   children: [
//                     // if (_post.length != null && _post.isNotEmpty)

//                     Row(
//                       children: [
//                         // for (int i =
//                         //         _post.length - 1;
//                         //     i < _post.length;
//                         //     i++)
//                         if (_post[i].user.image != null)
//                           Positioned(
//                             top: 0,
//                             left: 0,
//                             child: ClipOval(
//                               child: CachedNetworkImage(
//                                 imageUrl:
//                                     'http://localhost:8000/api${_post[i].user.image}',
//                                 placeholder: (context, url) =>
//                                     CircularProgressIndicator(),
//                                 errorWidget: (context, url, error) =>
//                                     Icon(Icons.error),
//                                 fit: BoxFit.cover,
//                                 width: 70,
//                                 height: 70,
//                               ),
//                             ),
//                           ),

//                         SizedBox(width: 25),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             // for (int i = 0; i > _post.length;  i++)
//                             Text(
//                               '${_post[i].user.fullname}',
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold, fontSize: 16),
//                             ),
//                             SizedBox(height: 8),
//                             Text(
//                               '@${_post[i].user.username}',
//                               style: TextStyle(
//                                 fontSize: 13,
//                                 color: Colors.blueGrey,
//                               ),
//                             ),
//                             SizedBox(height: 8),
//                             Text(
//                               'Posted on ${(_post[i].createAt)}',
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 color: Colors.grey,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 15),
//                     Padding(
//                       padding:
//                           // (_post[i].media.length >0) ?
//                           EdgeInsets.only(top: 100),
//                       //: EdgeInsets.only(
//                       // top: 130),
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             _post[i].content,
//                             style: TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 7),
//               //  (_post[i].media.length > 0) ?Center(
//               //       child: (_post[i].media.length > 0)
//               //           ? AspectRatio(
//               //               aspectRatio: 18 / 7,
//               //               child: ListView.builder(
//               //                 itemCount:
//               //                     //  _post.length,
//               //                     _post[i].media.length,
//               //                 itemBuilder: (context, index) {
//               //                   final post = _post[index].media;
//               //                   bool ischangecolor = false;
//               //                   return ListTile(
//               //                       title: Center(
//               //                     child: ClipRRect(
//               //                       borderRadius: BorderRadius.circular(5.0),
//               //                       child: AspectRatio(
//               //                           aspectRatio: 20 / 10,
//               //                           // if (post.user.image != null)
//               //                           child: CachedNetworkImage(
//               //                             imageUrl:
//               //                                 'http://localhost:8000/api${_post[i].media[index]['file']}',
//               //                             placeholder: (context, url) =>
//               //                                 CircularProgressIndicator(),
//               //                             errorWidget: (context, url, error) =>
//               //                                 Icon(Icons.error),
//               //                             fit: BoxFit.cover,
//               //                             width: 100,
//               //                             height: 100,
//               //                           )),
//               //                     ),
//               //                   ));
//               //                 },
//               //               ),
//               //             )
//               //           : ListTile()
//               //           ):Center(),
//                 // SizedBox(height: 15),
//                 Expanded(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       InkWell(
//                            onTap: () async {
//     final dio = Dio();
//     final cookie = getCookie('acessToken');
//     final id = _post[i].id; // Remove unnecessary curly braces
//     print(id);

//     try {
//       final response = await dio.put(
//         'http://localhost:8000/api/tweet/like/${id}',
//         options: Options(
//           headers: {
//             'Content-Type': 'application/json',
//             'Authorization': 'Bearer $cookie',
//           },
//         ),
//         data: {
//           'client_id': 'pYCSiQllhFFivVInLE7Y4DHEdYSqkGgG3jJMxcQd',
//         },
//       );

//       final Map<String, dynamic> responseBody = response.data;
//       final String state = responseBody['state'];

//       setState(() {
//         userLike = state;
//       });

//       print('follow1: $response');
//       print('Following: $userLike');
//       // print('follow3: $state');
//       print('cookie: $cookie');
//     } catch (error) {
//       print('Error: $error');
//     }
//   },
//   child: Icon(
//     Icons.favorite,
//     color: (userLike == 'dislike') ? Colors.red : Colors.grey,
//   ),
// ),
// SizedBox(width: 8),
// Text(
//   '${(userLike == 'dislike') ? _post[i].likes.count-- : _post[i].likes.count++}',
// ),
//                       SizedBox(width: 90),
//                       InkWell(
//                           onTap: () {
//                             // setState(() {
//                             //   ischangecolor =
//                             //       !ischangecolor;
//                             // });
//                           },
//                           child: Icon(Icons.comment, color: Colors.blue)),
//                       SizedBox(width: 8),
//                       // for (int i = 0;
//                       //     i > _post.length;
//                       //     i++)
//                       Text('${_post[i].comments.count}'),
//                       SizedBox(width: 90),
//                       InkWell(
//                           onTap: () {
//                             //  setState(() {
//                             // ischangecolor = !ischangecolor;
//                             // });
//                           },
//                           child: Icon(Icons.reply, color: Colors.green)),
//                       SizedBox(width: 8),
//                       // for (int i = 0;
//                       //     i > _post.length;
//                       //     i++)
//                       Text('${_post[i].replies.count}'),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
  }
}


// 

// class FollowButton extends StatefulWidget {
//   final PostModel like;
//    final dio ;
   

//   const FollowButton({required this.like, required this.dio});

//   @override
//   _FollowButtonState createState() => _FollowButtonState();
// }

// class _FollowButtonState extends State<FollowButton> {
// //  late bool? isFollowing ;
//   String? usersLike;

//   @override
//   Widget build(BuildContext context) {
//     return  InkWell(
//                           onTap: () {
//                             setState(() {
//                               ischangecolor = !ischangecolor;
//                             });
//                           },
//                           child: Icon(Icons.favorite,
//                               color: ischangecolor ? Colors.grey : Colors.red)),
                      // SizedBox(width: 8),
                      // // for (int i = 0;
                      // //     i > _post.length;
                      // //     i++)
                      // Text(
                      //     '${ischangecolor ? _post[i].likes.count++ : _post[i].likes.count--}'),

    // InkWell(
    //   onTap: () async {
    //     final cookie = getCookie('acessToken');
    //     final username = getCookie('username');
    //     final response = await widget.dio.put(
    //       'http://localhost:8000/api/user/follow/$username',
    //       options: Options(
    //         headers: {
    //           'Content-Type': 'application/json',
    //           'Authorization': 'Bearer $cookie',
    //         },
    //       ),
    //       data: {
    //         'client_id': 'pYCSiQllhFFivVInLE7Y4DHEdYSqkGgG3jJMxcQd',
    //       },
    //     );

    //     final Map<String, dynamic> responseBody = response.data;
    //     final String state = responseBody['state'];

    //     setState(() {
    //       usersLike = state ;
    //     });

    //     print('follow1: $response');
    //     // print('isFollowing: $isFollowing');
    //     print('follow3: $state');
    //     print('folcookie: $cookie');
    //   },
    //   child: Container(
    //       height: 30,
    //                       width: 100,
    //                       decoration: BoxDecoration(
    //                         color: Colors.black,
    //                         borderRadius: BorderRadius.circular(15),
    //                       ), // Button container details
    //                  child:Center(     
    //     child: Text(
    //       (usersLike == 'unfollow') ? 'Follow' : 'unFollow',
    //       style: TextStyle(
    //         color: Colors.white,
    //       ),
    //     ),
    //     ),
    //   ),
    // );
  // }
// }