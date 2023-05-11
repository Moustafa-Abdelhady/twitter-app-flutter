import 'package:flutter/material.dart';
import 'package:twitter_clone/bottombar.dart';
// import 'package:twitter_clone/views/pages/homepage.dart';

class Splashpage extends StatefulWidget {
  const Splashpage({Key? key}) : super(key: key);

  @override
  _SplashpageState createState() => _SplashpageState();
}

class _SplashpageState extends State<Splashpage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1)).then((value) => Navigator.push(
        context, MaterialPageRoute(builder: (context) => Bottombar())));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 150,
          width: 150,
          decoration: const BoxDecoration(
              image:
                  DecorationImage(image: AssetImage('assets/twitterlogo.png'))),
        ),
      ),
    );
  }
}
