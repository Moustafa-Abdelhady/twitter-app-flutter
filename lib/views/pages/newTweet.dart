import 'dart:async';

import 'dart:convert';

import 'dart:io';

import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import 'package:twitter_clone/views/pages/homepage.dart';

import 'dart:html' as html;






class NewTweet extends StatefulWidget {

 const NewTweet({super.key});





 @override

 State<NewTweet> createState() => _NewTweetState();

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


  

class _NewTweetState extends State<NewTweet> {

 


bool _isButtonDisabled = true;

final _textEditingController = TextEditingController();

void CreateTweet(String content) async {

   final cookiee = getCookie('acessToken');
   final userid = getCookie('id');
    print('userid: ${userid}');
    print('cookiee: ${cookiee}');
    String? access_token = cookiee;

 var url = Uri.http('localhost:8000', 'api/tweet/create');




// var imageBytes, videoBytes;

// String? imageBase64, videoBase64;




 // if (_imageFile != null) {

 //   imageBytes = await _imageFile!.readAsBytes();

 //   imageBase64 = base64.encode(imageBytes);

 // }






 var response = await http.post(

url,

 body: {

 'content': content,
  'accesstoken':access_token,
 'user': '2',

 },

 headers: {

 // 'Content-Type':'multipart/form-data',

'Authorization': 'Bearer ${access_token}',

},

);




 if (response.statusCode == 201) {

print('Tweet created successfully!');

content = '';

Navigator.push(

 context,

 MaterialPageRoute(builder: (context) => Homepage()),

 );

 } else {

 print('Error creating tweet: ${response.statusCode}');

 }

}






@override

Widget build(BuildContext context) {

return Scaffold(

 appBar: AppBar(

 title: Text('New Tweet'),

),

body: Column(

 children: <Widget>[

 const SizedBox(height: 20),

 Padding(

padding: const EdgeInsets.symmetric(horizontal: 20),

 child: TextField(

 controller: _textEditingController,

onChanged: (text) {

 setState(() {

_isButtonDisabled = text.isEmpty;

});

 },

 decoration: const InputDecoration(

 hintText: 'What\'s happening?',

 ),

 maxLength: 280,

),

),

Row(

 mainAxisAlignment: MainAxisAlignment.spaceEvenly,

children: [


ElevatedButton(

onPressed: _isButtonDisabled

? null

: () {

CreateTweet(_textEditingController.text);
ScaffoldMessenger.of(context).showSnackBar(

 SnackBar(

content: Text('tweet created'),

 ),

);

},

child: Text('tweet'),

),

],

 ),



],

),

 );

 }

}