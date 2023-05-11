import 'package:flutter/material.dart';
import 'package:twitter_clone/views/pages/splashpage.dart';
import 'package:twitter_clone/views/pages/loginpage.dart';
import 'dart:html' as html;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
  final cookie = getCookie('acessToken');
   if (cookie != null) {
      return MaterialApp(
        // theme: ThemeData(
        //   useMaterial3: true,
        // ),
        debugShowCheckedModeBanner: false,
        home: Splashpage(),
      );
    } else {
      return MaterialApp(
        // theme: ThemeData(
        //   useMaterial3: true,
        // ),
        debugShowCheckedModeBanner: false,
        home: Loginpage(),
      );
    }
  }
}

 