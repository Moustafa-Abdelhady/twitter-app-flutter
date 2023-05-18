import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:twitter_clone/main.dart';
import 'package:twitter_clone/views/pages/profilepage.dart';
import 'package:dio/dio.dart';
import 'dart:html' as html;
import '../../models/postsModel.dart';
import '../../services/post_data.dart';
import '../../models/userModel.dart';
import '../../services/user_data.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ProfilepageState createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  final PostService _postService = PostService();
  List<PostModel> _post = [];
  // late Future<List<PostModel>> _postList;
  bool ischangecolor = false;

  //users
  final UserService _userService = UserService();
  UserModel? _user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _postList = PostService().postData();
    getUserData();
    getPostsData();
  }

  Future<dynamic> getPostsData() async {
    // final postService = PostService();
    final posts = await _postService.postData();
    // final _postList = await postService.postData();

    setState(() {
      _post = posts;
    });
  }

  Future<dynamic> getUserData() async {
    print('getUserData in profile page Calld');

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
    return Scaffold(
    
      body:
          SingleChildScrollView(
            child: Expanded(
              child: Column(
                    children: [
              // SingleChildScrollView(
              //            scrollDirection: Axis.vertical,
              // physics: const BouncingScrollPhysics(),
              // child: 
              // Column(
               
                // children: [
                 
                  coverimage(_user),
                  profile(_user),
                // ],
              // ),
                      // ),
              // SizedBox(height:5),
               ListView.builder(
                 shrinkWrap: true,
                 physics: NeverScrollableScrollPhysics(),
                 itemCount: _post.length,
                 itemBuilder: (context, index) {
                   final post = _post[index];
                      
                    return Container(
                     height: MediaQuery.of(context).size.height * 0.4,
                    child: Card(
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(20.0),
                         side: BorderSide(color: Colors.grey.shade300),
                       ),
                       margin:
                           EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
                       child: InkWell(
                         onTap: () {
                           Navigator.push(
                             context,
                             MaterialPageRoute(
                               builder: (context) => PostDetailScreen(post: post),
                             ),
                           );
                         },
                         child: Padding(
                           padding: EdgeInsets.symmetric(horizontal: 40.0),
                           child: Row(
                             children: [
                               ClipOval(
                                 child: Container(
                                   width: 80,
                                   height: 120,
                                   decoration: BoxDecoration(
                                     shape: BoxShape.circle,
                                   ),
                                   child: CachedNetworkImage(
                                     imageUrl:
                                         'http://localhost:8000/api${post.user.image}',
                                     placeholder: (context, url) =>
                                         CircularProgressIndicator(),
                                     errorWidget: (context, url, error) =>
                                         Icon(Icons.error),
                                     fit: BoxFit.cover,
                                   ),
                                 ),
                               ),
                               SizedBox(width: 10.0),
                               Expanded(
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   children: [
                                     Text(
                                       post.user.fullname,
                                       style:
                                           TextStyle(fontWeight: FontWeight.bold),
                                     ),
                                     Text(
                                       post.content,
                                       maxLines: 1,
                                       overflow: TextOverflow.ellipsis,
                                       style: TextStyle(
                                         color: Colors.grey.shade600,
                                         fontSize: 12.0,
                                       ),
                                     ),
                                     SizedBox(height: 25),
                                     Row(
                                       //////////////
                                       children: [
                                         InkWell(
                                             onTap: () {
                                               // setState(() {
                                               //   ischangecolor = !ischangecolor;
                                               // });
                                             },
                                             child: Icon(Icons.favorite,
                                                 color: ischangecolor
                                                     ? Colors.red
                                                     : Colors.grey)),
                                         SizedBox(width: 8),
                                         Text(
                                             '${ischangecolor ? post.likes.count++ : post.likes.count--}'),
                                         SizedBox(width: 16),
                                         InkWell(
                                             onTap: () {
                                               // setState(() {
                                               // ischangecolor = !ischangecolor;
                                               // });
                                             },
                                             child: Icon(Icons.comment,
                                                 color: Colors.blue)),
                                         SizedBox(width: 8),
                                         Text('${post.comments.count}'),
                                         SizedBox(width: 16),
                                         InkWell(
                                             onTap: () {
                                               //  setState(() {
                                               // ischangecolor = !ischangecolor;
                                               // });
                                             },
                                             child: Icon(Icons.reply,
                                                 color: Colors.green)),
                                         SizedBox(width: 8),
                                         Text('${post.replies.count}'),
                                       ],
                                     ),
                                   ],
                                 ),
                               ),
                               SizedBox(width: 10.0),
                               IconButton(
                                 icon: Icon(Icons.more_vert),
                                 onPressed: () {},
                               ),
                             ],
                           ),
                         ),
                       ),
                     ),
                   );
                 },
               ),
                    ],
                  ),
            ),
          ),
      //  ],
      // ),
    );
  }
  
Widget coverimage(UserModel? _user) {
  return (_user?.profile?.coverImage != null)
      ? Container(
          height: 150,
          decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                  fit: BoxFit.cover, image: NetworkImage('http://localhost:8000/api${_user?.profile?.coverImage}'))),
        )
      : CircleAvatar(
          radius: 30,
        );
}



Widget profile(UserModel? _user) {
  return Container(
    // height:250,
    transform: Matrix4.translationValues(10.0, -50.0, 20.0),
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),

    child: (_user != null)
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if(_user != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  (_user?.profile?.image != null)?
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 45,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage('http://localhost:8000/api${_user?.profile?.image}'),
                      radius: 43,
                    ),
                  ):CircularProgressIndicator(),
                  // TextButton(
                  //     onPressed: () {},
                  //     child: Text('Edit Profile',
                  //         style: TextStyle(color: Colors.blue)))
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '${_user.fullname}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '@${_user.username}',
                style: TextStyle(fontSize: 15, color: Colors.grey),
              ),
              SizedBox(
                height: 15,
              ),
               Text(
                'BirthDate:${_user.birthdate}',
                style: TextStyle(fontSize: 15, color: Color.fromARGB(255, 87, 85, 85)),
              ),
              SizedBox(
                height: 5,
              ),
                Text(
                'Location:${_user.profile?.location}',
                style: TextStyle(fontSize: 15, color: Color.fromARGB(255, 87, 85, 85)),
              ),
              SizedBox(
                height: 5,
              ),
                
              Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 15,
                  ),
                  Text('Joined ${_user.createAt}',
                      style: TextStyle(fontSize: 15, color: Color.fromARGB(255, 87, 85, 85)))
                ],
              ),
               SizedBox(
                height: 5,
              ),
               Text(
                '${_user?.profile?.bio}',
                style: TextStyle(fontSize: 15, color: Color.fromARGB(255, 87, 85, 85)),
              ),
              SizedBox(
                height: 5,
              ),
               Text(
                '${_user?.profile?.website}',
                style: TextStyle(fontSize: 15, color: Colors.blueAccent),
              ),
             
            
              SizedBox(
                height: 15,
              ),
              Row(
                children:  [
                   (_user.following?.length != null)
                  ?Text(
                    '${_user?.following?.length} ',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ): Text('0 '),
                  Text(
                    'Following',
                    style: TextStyle(
                        color: Color.fromARGB(255, 87, 85, 85),
                        fontSize: 13),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  (_user?.followers?.length != null)
                  ?Text(
                    '${_user?.followers?.length} ',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ): Text(' 0 '),
                  Text(
                    'Followers',
                    style: TextStyle(
                        color: Color.fromARGB(255, 87, 85, 85),
                        fontSize: 13),
                  )
                ],
              ),
            ],
          )
        : Center(child: CircularProgressIndicator()),
  );
}



}



class PostDetailScreen extends StatelessWidget {
  final PostModel post;

  PostDetailScreen({required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tweet Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                if (post != null && post != Null)
                  // if (post.user.image != null)
                  Row(
                    children: [
                      if (post != null && post != false)
                        if (post.user.image != null)
                          Positioned(
                            top: 0,
                            left: 0,
                            child: ClipOval(
                              child: CachedNetworkImage(
                                imageUrl:
                                    'http://localhost:8000/api${post.user.image}',
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                                fit: BoxFit.cover,
                                width: 60,
                                height: 60,
                              ),
                            ),
                          ),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${post.user.fullname} (@${post.user.username})',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Posted on ${DateFormat.yMMMMEEEEd().format(post.createAt)}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                SizedBox(height: 30),
                Padding(
                  padding: EdgeInsets.only(top: 110),
                  child: Center(
                    child: Text(
                      post.content,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            AspectRatio(
              aspectRatio: 16 / 9,
              child: ListView.builder(
                itemCount: post.media.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: AspectRatio(
                            aspectRatio: 1.0,
                            // if (post.user.image != null)
                            child: post.user.image != null
                                ? CachedNetworkImage(
                                    imageUrl:
                                        'http://localhost:8000/api${post.media[index]['file']}',
                                    placeholder: (context, url) =>
                                        CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                    fit: BoxFit.contain,
                                  )
                                : CircularProgressIndicator()),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 25),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite, color: Colors.red),
                  SizedBox(width: 8),
                  Text('${post.likes.count}'),
                  SizedBox(width: 16),
                  Icon(Icons.comment, color: Colors.blue),
                  SizedBox(width: 8),
                  Text('${post.comments.count}'),
                  SizedBox(width: 16),
                  Icon(Icons.reply, color: Colors.green),
                  SizedBox(width: 8),
                  Text('${post.replies.count}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//////////////////
// class _ProfilepageState extends State<Profilepage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           ListView(
//             physics: const BouncingScrollPhysics(
//                 parent: AlwaysScrollableScrollPhysics()),
//             children: [coverimage(),profile()],
//           ),
//           Column(
//             children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: _post.length,
//               itemBuilder: (context, index) {
//                 final post = _post[index];
//                  bool ischangecolor=false;
//             for(int i=_post.length-1 ; i<_post.length;i++);
//                 return  Container(
//                    height: MediaQuery.of(context).size.height * 6,
//                   //  for(int i=_post.length-1 ; i<_post.length;i++)
//                   child: Card(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15.0),
//                       side: BorderSide(color: Colors.grey.shade300),
//                     ),
//                     margin:
//                         EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
//                     child: InkWell(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => PostDetailScreen(post: post),
//                           ),
//                         );
//                       },
//                       child: Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 40.0),
//                         child: Row(
//                           children: [/////////image profle page
//                             InkWell(
//                               onTap: (){
//                                  Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => Profilepage(),
//                           ),
//                         );/////////////
//                               },
//                               child: ClipOval(
//                                 child: Container(
//                                   width: 60,
//                                   height: 60,
//                                   decoration: BoxDecoration(
//                                     shape: BoxShape.circle,
//                                   ),
//                                   child: CachedNetworkImage(
//                                     imageUrl:
//                                         'http://localhost:8000/api${_post[i].user.image}',
//                                     placeholder: (context, url) =>
//                                         CircularProgressIndicator(),
//                                     errorWidget: (context, url, error) =>
//                                         Icon(Icons.error),
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(width: 10.0),
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                     post.user.fullname,
//                                     style:
//                                         TextStyle(fontWeight: FontWeight.bold),
//                                   ),
//                                   Text(
//                                     post.content,
//                                     maxLines: 1,
//                                     overflow: TextOverflow.ellipsis,
//                                     style: TextStyle(
//                                       color: Colors.grey.shade600,
//                                       fontSize: 12.0,
//                                     ),
//                                   ),

//                                   SizedBox(height: 25),
//                                    Row(//////////////
//               children: [
//                 InkWell(onTap: (){ischangecolor!=ischangecolor;},child: Icon(Icons.favorite, color:ischangecolor? Colors.grey :Colors.red)),
//                 SizedBox(width: 8),
//                 Text('${post.likes.count}'),
//                 SizedBox(width: 16),
//                 InkWell(onTap: (){ischangecolor!=ischangecolor;},child:Icon(Icons.comment, color:ischangecolor? Colors.grey: Colors.blue)),
//                 SizedBox(width: 8),
//                 Text('${post.comments.count}'),
//                 SizedBox(width: 16),
//                  InkWell(onTap: (){ischangecolor!=ischangecolor;},child:Icon(Icons.reply, color:ischangecolor? Colors.grey: Colors.green)),
//                 SizedBox(width: 8),
//                 Text('${post.replies.count}'),
//               ],
//             ),
//                                 ],
//                               ),
//                             ),
//                             SizedBox(width: 10.0),
//                             IconButton(
//                               icon: Icon(Icons.more_vert),
//                               onPressed: () {},
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//           )

//         ],
//       ),
//     );
//   }

//   Widget coverimage() {
//     return Container(
//       height: 150,
//       decoration: BoxDecoration(
//           color: Colors.blue,
//           image: DecorationImage(
//               fit: BoxFit.cover, image: AssetImage('marym.jpg'))),
//     );
//   }

//   Widget profile() {
//     return Container(
//       transform: Matrix4.translationValues(0.0, -50.0, 0.0),
//       padding: const EdgeInsets.symmetric(horizontal: 15),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               CircleAvatar(
//                 backgroundColor: Colors.white,
//                 radius: 45,
//                 child: CircleAvatar(
//                   backgroundImage: AssetImage('assets/imgflo.jpg'),
//                   radius: 43,
//                 ),
//               ),
//               TextButton(
//                   onPressed: () {},
//                   child: Text('Edit Profile',
//                       style: TextStyle(color: Colors.blue)))
//             ],
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Text(
//             'Engy Mohammed',
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(
//             height: 5,
//           ),
//           Text(
//             '@engy5821',
//             style: TextStyle(fontSize: 15, color: Colors.grey),
//           ),
//           SizedBox(
//             height: 15,
//           ),
//           Row(
//             children: [
//               Icon(
//                 Icons.calendar_today_outlined,
//                 size: 15,
//               ),
//               Text('Joined December 2022',
//                   style: TextStyle(fontSize: 15, color: Colors.grey))
//             ],
//           ),
//           SizedBox(
//             height: 15,
//           ),
//           Row(
//             children: const [
//               Text(
//                 '0 ',
//                 style:
//                     TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//               ),
//               Text(
//                 'Following',
//                 style: TextStyle(
//                     color: Color.fromARGB(255, 143, 141, 141), fontSize: 13),
//               ),
//               SizedBox(
//                 width: 20,
//               ),
//               Text(
//                 '0 ',
//                 style:
//                     TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//               ),
//               Text(
//                 'Followers',
//                 style: TextStyle(
//                     color: Color.fromARGB(255, 143, 141, 141), fontSize: 13),
//               )
//             ],
//           ),
//         ],
//       ),
//     );
//   }

// }
