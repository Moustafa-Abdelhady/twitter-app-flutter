import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone/views/pages/profilepage.dart';
import 'package:twitter_clone/views/pages/loginpage.dart';
import 'package:twitter_clone/views/pages/newTweet.dart';
import 'package:twitter_clone/main.dart';
import 'dart:html' as html;
import 'package:dio/dio.dart';
import '../../models/postsModel.dart';
import '../../services/post_data.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
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
  final postService = PostService();
  List<PostModel> _post = [];

  // late Future<List<PostModel>> _postList;
  bool loaded = false;
  bool ischangecolor = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _postList = PostService().postData();
    loaded = true;
    getUserData();
  }

  final cookie = getCookie('acessToken');
  final id = getCookie('id');

  Future<dynamic> getUserData() async {
    print('loool1 $_post');
    final posts = await postService.postData();
    print('lool $posts');

    if (posts != null && posts.isNotEmpty) {
      setState(() {
        _post = posts;
        ischangecolor = !ischangecolor;
        print('loool$_post');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return loaded != false
        ? Scaffold(
            drawer: Drawer(
                backgroundColor: Colors.white,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    if (_post.length != null && _post.isNotEmpty)
                      // Expanded(
                      // child:  ListView.builder(

                      // itemCount: _post.length,
                      // itemBuilder: (context, index) {
                      // final post = _post[index];
                      // return
                      Column(
                        children: [
                          for (int i = 0; i < _post.length; i)
                            if (_post[i].user.image != null)
                              UserAccountsDrawerHeader(
                                currentAccountPictureSize: Size.fromRadius(30),
                                decoration: BoxDecoration(color: Colors.white),
                                currentAccountPicture: ClipOval(
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        'http://localhost:8000/api${_post[i].user.image}',
                                    placeholder: (context, url) =>
                                        CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                    fit: BoxFit.cover,
                                    width: 100,
                                    height: 100,
                                  ),
                                ),
                                accountName: Text(
                                  _post[0].user.fullname,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                accountEmail: Text(
                                  _post[0].user.username,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 143, 141, 141),
                                  ),
                                ),
                              ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15, left: 15),
                            child: Row(
                              children: [
                                Text(
                                  '0',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Following',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 143, 141, 141),
                                      fontSize: 13),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  '0',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Followers',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 143, 141, 141),
                                      fontSize: 13),
                                )
                              ],
                            ),
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.person,
                              color: Colors.black,
                            ),
                            title: Text('Profile',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600)),
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
                                  fontSize: 18, fontWeight: FontWeight.w600),
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
                                  fontSize: 18, fontWeight: FontWeight.w600),
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
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            onTap: () {},
                          ),
                        ],
                      ),
                    // }))
                  ],
                )),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
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
                                    child: const CircleAvatar(
                                      radius: 20,
                                      backgroundImage:
                                          AssetImage('assets/imgflo.jpg'),
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
                                Container(
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      final dio = Dio();
                                      // Add your button press logic here

                                      print(cookie);
                                      print('lool');

                                      deleteCookie('acessToken');
                                      deleteCookie('id');

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
                                )
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
                            const SizedBox(
                              height: 2,
                            ),
                            Column(
                              children: [
                                if (_post.length != null && _post.isNotEmpty)
                                  // Expanded(
                                  // child:
                                  //  ListView(
                                  // itemCount: _post.length,
                                  // itemBuilder: (context, index) {
                                  // final post = _post[index];
                                  for (int i = 0; i < _post.length; i++)

                                    // return
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.6,
                                      child: Card(
                                        // shape: RoundedRectangleBorder(
                                        //   borderRadius:
                                        //       BorderRadius.circular(5.0),
                                        //   side: BorderSide(
                                        //       color: Colors.grey.shade300),
                                        // ),
                                        // margin: EdgeInsets.symmetric(
                                        //     vertical: 1.0, horizontal: 0.0),
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
                                            padding: EdgeInsets.symmetric(
                                                vertical: 20, horizontal: 40.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                if (_post.length != null &&
                                                    _post.isNotEmpty)
                                                  Stack(
                                                    children: [
                                                      // if (_post.length != null && _post.isNotEmpty)

                                                      Row(
                                                        children: [
                                                          for (int i =
                                                                  _post.length -
                                                                      1;
                                                              i < _post.length;
                                                              i++)
                                                            if (_post[i]
                                                                    .user
                                                                    .image !=
                                                                null)
                                                              Positioned(
                                                                top: 0,
                                                                left: 0,
                                                                child: ClipOval(
                                                                  child:
                                                                      CachedNetworkImage(
                                                                    imageUrl:
                                                                        'http://localhost:8000/api${_post[i].user.image}',
                                                                    placeholder:
                                                                        (context,
                                                                                url) =>
                                                                            CircularProgressIndicator(),
                                                                    errorWidget: (context,
                                                                            url,
                                                                            error) =>
                                                                        Icon(Icons
                                                                            .error),
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    width: 70,
                                                                    height: 70,
                                                                  ),
                                                                ),
                                                              ),
                                                          SizedBox(width: 25),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              // for (int i = 0; i > _post.length;  i++)
                                                              Text(
                                                                '${_post[0].user.fullname}',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        16),
                                                              ),
                                                              SizedBox(
                                                                  height: 8),
                                                              Text(
                                                                '@${_post[0].user.username}',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 13,
                                                                  color: Colors
                                                                      .blueGrey,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  height: 8),
                                                              Text(
                                                                'Posted on ${(_post[i].createAt)}',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .grey,
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
                                                            EdgeInsets.only(
                                                                top: 100),
                                                                //: EdgeInsets.only(
                                                                // top: 130),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                          children: [
                                                            
                                                               Text(
                                                                _post[i].content,
                                                                style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                           
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                SizedBox(height: 7),
                                               Center(
                                                 child:
                                                //  (_post[i].media.length >0) ?
                                                 AspectRatio (
                                                    aspectRatio: 18 / 7,
                                                    child: ListView.builder(
                                                      itemCount:
                                                          _post[i].media.length,
                                                          
                                                      itemBuilder:
                                                          (context, index) {
                                                        
                                                        return ListTile(
                                                         
                                                          title: Center(
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5.0),
                                                              child: AspectRatio(
                                                                  aspectRatio:
                                                                      20 / 10,
                                                                  // if (post.user.image != null)
                                                                  child:  CachedNetworkImage(
                                                                          imageUrl:
                                                                              'http://localhost:8000/api${_post[i].media[index]['file']}',
                                                                          placeholder:
                                                                              (context, url) =>
                                                                                  CircularProgressIndicator(),
                                                                          errorWidget: (context,
                                                                                  url,
                                                                                  error) =>
                                                                              Icon(Icons.error),
                                                                          fit: BoxFit
                                                                              .cover,
                                                                          width:
                                                                              300,
                                                                          height:
                                                                              300,
                                                                        )
                                                                      
                                                                      ),
                                                            ),
                                                          )
                                                        );
                                                      },
                                                    ),
                                                  )
                                                  // :SizedBox(height:140)
                                               ),
                                                SizedBox(height: 15),
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              ischangecolor =
                                                                  !ischangecolor;
                                                            });
                                                          },
                                                          child: Icon(
                                                              Icons.favorite,
                                                              color:
                                                                  ischangecolor
                                                                      ? Colors
                                                                          .grey
                                                                      : Colors
                                                                          .red)),
                                                      SizedBox(width: 8),
                                                      // for (int i = 0;
                                                      //     i > _post.length;
                                                      //     i++)
                                                         Text('${ischangecolor?_post[i].likes.count++ : _post[i].likes.count--}'),
                                                      SizedBox(width: 25),
                                                      InkWell(
                                                          onTap: () {
                                                            // setState(() {
                                                            //   ischangecolor =
                                                            //       !ischangecolor;
                                                            // });
                                                          },
                                                          child: Icon(
                                                              Icons.comment,
                                                              color:
                                                                  Colors.blue)),
                                                      SizedBox(width: 8),
                                                      // for (int i = 0;
                                                      //     i > _post.length;
                                                      //     i++)
                                                        Text(
                                                            '${_post[i].comments.count}'),
                                                      SizedBox(width: 25),
                                                      InkWell(
                                                          onTap: () {
                                                            //  setState(() {
                                                            // ischangecolor = !ischangecolor;
                                                            // });
                                                          },
                                                          child: Icon(
                                                              Icons.reply,
                                                              color: Colors
                                                                  .green)),
                                                      SizedBox(width: 8),
                                                      // for (int i = 0;
                                                      //     i > _post.length;
                                                      //     i++)
                                                        Text(
                                                            '${_post[i].replies.count}'),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                // },
                                // ),
                                // ),
                              ],
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            ),
          )
        : CircularProgressIndicator();
  }
}
