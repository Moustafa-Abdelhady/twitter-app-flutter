// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:twitter_clone/views/pages/Splashpage.dart';
import 'package:twitter_clone/views/pages/registerpage.dart';
import 'package:dio/dio.dart';
import 'dart:html' as html;
// import 'package:universal_html/html.dart' ;
import '../../models/apiModel.dart';
import '../../services/api_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _LoginpageState createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  GlobalKey<FormState> scaffoldKey = GlobalKey<FormState>();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ///google authantication
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<String?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw e;
    }
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

  ////test Api///
  ApiData authService = ApiData();

  Future<String> getDataFromApi() async {
    try {
      final auth = await authService.getApiData(
        client_id: 'pYCSiQllhFFivVInLE7Y4DHEdYSqkGgG3jJMxcQd',
        client_secret:
            'kn6C0iAr4MDmBIkX7xJLI3NCILmM6aRsiHV6biK6tgTSVeVbgFa9ZoFC5wzmJ1GzdkyD8XZ0kZj1C9Mw4JPMBEervL2iaDR7sq9X05ifFI6zymX5H8yKh1OmP6LE04TU',
        grant_type: 'password',
        username: username.text,
        password: password.text,
      );
      print('accessToken: ${auth.accessToken}');
      return auth.accessToken!;
    } on DioError catch (e) {
      print('Error in requested: $e');
      return null!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 11.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
              ),
              Image.asset(
                'assets/twitterlogo.png',
                height: 80,
                width: 80,
              ),
              Text(
                'Sign in to Twitter!',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              Container(
                width: double.infinity,
                height: 40.0,
                child: OutlinedButton.icon(
                  onPressed: () async {
                    // Handle sign in with Google logic here
                
                    print('Sign in with Google clicked');
                    try {
                  await signInWithGoogle();
                  Navigator.push(
                   context,
                    MaterialPageRoute(builder: (context) => Splashpage()),
                 );
                } catch (e) {
                print('Failed to sign in with Google: $e');
                     } 
                  },
                  icon: Image.asset(
                    'assets/google.png',
                    height: 20,
                    width: 20,
                  ),
                  label: Text('Sign in with Google'),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            13.0), // Specify desired radius
                      ),
                    ),
                  ),
                ),
              ),
              // SizedBox(height: 6.0),
              // Container(
              //   width: double.infinity,
              //   height: 40.0,
              //   child: OutlinedButton.icon(
              //     onPressed: () {
              //       // Handle sign in with Github logic here
              //     },
              //     icon: Image.asset(
              //       'assets/GitHub-Mark.png',
              //       height: 20,
              //       width: 20,
              //     ),
              //     label: Text('Sign in with Github'),
              //     style: ButtonStyle(
              //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              //         RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(
              //               13.0), // Specify desired radius
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              SizedBox(height: 9.0),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: 14.0),
                    TextFormField(
                      autofocus: true,
                      controller: username,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter username ';
                        }
                        // Regular expression to validate date in format 'dd/MM/yyyy'
                        final mailRegex = RegExp(r'^[a-zA-Z0-9_-]+$');
                        if (!mailRegex.hasMatch(value)) {
                          return 'Please enter a valid username';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'username',
                        hintText: 'Enter username',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    // ),
                    SizedBox(height: 9.0),
                    // Padding(
                    //      padding: EdgeInsets.symmetric(horizontal: 14.0),
                    TextFormField(
                      controller: password,
                      obscureText: true,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 2) {
                          return 'Please enter a Password bigger than 8 characters';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    // )
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 40.0,
                child: OutlinedButton.icon(
                  onPressed: () async {
                    //  String email = username.text;
                    //  String password = password.text;
                    if (_formKey.currentState!.validate()) {
                    /////test Api////
                    final authData = await getDataFromApi();
                    final dio = Dio();

                    print('authData : $authData');
                    if (authData != null) {
                      print('lol');
                      dio.options.headers['Authorization'] = 'Bearer $authData';
                      print('lolll');

                      final response =
                          await dio.post('http://localhost:8000/auth/token',
                              options: Options(
                                contentType: 'application/json',
                              ),
                              data: ({
                                'client_id':
                                    'pYCSiQllhFFivVInLE7Y4DHEdYSqkGgG3jJMxcQd',
                                'client_secret':
                                    'kn6C0iAr4MDmBIkX7xJLI3NCILmM6aRsiHV6biK6tgTSVeVbgFa9ZoFC5wzmJ1GzdkyD8XZ0kZj1C9Mw4JPMBEervL2iaDR7sq9X05ifFI6zymX5H8yKh1OmP6LE04TU',
                                'grant_type': 'password',
                                'username': username.text,
                                'password': password.text,
                              }));
                      //  final username = response.data['username'];
                      // final password = response.data['password'];
                      print(response.data);
                      print('lllolllllll');
                      ////// set access token to cookies here
                      //  final registerAuth = await registerDataFromApi();
                      //  print('registerAuthLogin : ${registerAuth}');
                      setCookie('acessToken', response.data['access_token']);
                      setCookie('username', username.text);

                      final cookie = getCookie('acessToken');
                      final usercookie = getCookie('username');

                      print(cookie);
                      print(usercookie);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .center, // Center the content
                                children: [
                              Icon(Icons.circle_outlined),
                              SizedBox(width: 8),
                              Text('Loading'),
                            ])),
                      );

                      // Navigator.of(context).push(
                      //   MaterialPageRoute(builder: (context) {
                      //     return Splashpage();
                      //   }),
                      // );

                      if (response.statusCode == 200) {
                        final responseData = response.data;
                        print('Response data: $responseData');
                      } else {
                        print(
                            'Request failed with status: ${response.statusCode}.');
                      }
                    }
                    // }
                    // Handle login logic here
                    // String email = username.text;
                    // String password = password.text;
                    // Perform authentication logic and handle success/failure
                    // if (_formKey.currentState!.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.

                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   SnackBar(
                    //     content: Row(
                    //       mainAxisAlignment:
                    //           MainAxisAlignment.center, // Center the content
                    //       children: [
                    //         Icon(Icons.circle_outlined),
                    //         SizedBox(width: 8),
                    //         Text('Loading'),
                    //       ],
                    //     ),
                    //   ),
                    // );
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return Splashpage();
                    }));
                    }
                  },
                  icon: Icon(Icons.login, color: Colors.white),
                  label: Text('Login', style: TextStyle(color: Colors.white)),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Colors.black87),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            13.0), // Specify desired radius
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 4.0),
              TextButton(
                onPressed: () {
                  // Navigate to registration page
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return Registerpage();
                  }));
                },
                child: Text('Dont have an account? Sign up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
