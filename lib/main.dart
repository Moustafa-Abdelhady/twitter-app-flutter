import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/views/pages/splashpage.dart';
import 'package:twitter_clone/views/pages/loginpage.dart';
import 'dart:html' as html;
import 'firebase_options.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      return const MaterialApp(
        // theme: ThemeData(
        //   useMaterial3: true,
        // ),
        debugShowCheckedModeBanner: false,
        home: Splashpage(),
      );
    } else {
      return const MaterialApp(
        // theme: ThemeData(
        //   useMaterial3: true,
        // ),
        debugShowCheckedModeBanner: false,
        home: Loginpage(),
      );
    }
  }
}

 