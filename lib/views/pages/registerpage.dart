import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:twitter_clone/views/pages/loginpage.dart';
import 'package:twitter_clone/views/pages/Splashpage.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart'; // Import the intl package for DateFormat
import 'package:dio/dio.dart';
import 'dart:html' as html;
import '../../models/apiModel.dart';
import '../../services/register_data.dart';

class Registerpage extends StatefulWidget {
  const Registerpage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _RegisterpageState createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  final TextEditingController _fullname = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _birthdate = TextEditingController();
  final TextEditingController _password = TextEditingController();
  GlobalKey<FormState> scaffoldKey = GlobalKey<FormState>();
 GlobalKey<FormState>  _formKey = GlobalKey<FormState>();

////test api////
  RegisterData registerAuthService = RegisterData();
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

  Future<dynamic> registerDataFromApi() async {
    try {
      final regAuth = await registerAuthService.postRegisterData(
          fullname: _fullname.text,
          username: _username.text,
          email: _email.text,
          birthdate: _birthdate.text,
          password: _password.text);
      print('regData: ${regAuth.username}');
      return regAuth.id;
    } on DioError catch (e) {
      print('Error in Reg requested: $e');
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
                height: 70,
                width: 70,
              ),
              Text(
                'Join Twitter today',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              Container(
                width: double.infinity,
                height: 35.0,
                child: OutlinedButton.icon(
                  onPressed: () {
                    // Handle sign in with Google logic here
                  },
                  icon: Image.asset(
                    'assets/google.png',
                    height: 20,
                    width: 20,
                  ),
                  label: Text('Sign up with Google'),
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
              SizedBox(height: 9.0),
              // Container(
              //   width: double.infinity,
              //   height: 35.0,
              //   child: OutlinedButton.icon(
              //     onPressed: () {
              //       // Handle sign in with Github logic here
              //     },
              //     icon: Image.asset(
              //       'assets/GitHub-Mark.png',
              //       height: 20,
              //       width: 20,
              //     ),
              //     label: Text('Sign up with Github'),
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
              // SizedBox(height: 9.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Create new account',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  // Add other widgets here as needed
                ],
              ),
              SizedBox(height: 3.0),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      autofocus: true,
                      controller: _fullname,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter fullname';
                        }
                        // Regular expression to validate date in format 'dd/MM/yyyy'
                        final fullnameRegex = RegExp(r'^[a-zA-Z]+ [a-zA-Z]+$');
                        if (!fullnameRegex.hasMatch(value)) {
                          return 'Please enter a valid fullname';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'FullName',
                        hintText: 'Enter fullname',
                        border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
                      ),
                    ),
                    SizedBox(height: 5.0),
                    TextFormField(
                      autofocus: true,
                      controller: _username,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a valid username';
                        }
                        // Regular expression to validate date in format 'dd/MM/yyyy'
                        final usernameRegex = RegExp(r'^[a-zA-Z0-9_-]+$');
                        if (!usernameRegex.hasMatch(value)) {
                          return 'Please enter valid username';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Username',
                        hintText: 'Enter Username',
                        border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
                      ),
                    ),
                    SizedBox(height: 5.0),
                    TextFormField(
                      autofocus: true,
                      controller: _email,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Mail example@email.com';
                        }
                        // Regular expression to validate date in format 'dd/MM/yyyy'
                        final mailRegex =
                            RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                        if (!mailRegex.hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'Enter Mail',
                        border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _birthdate,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your birthdate';
                              }
                              // Regular expression to validate date in format 'yyyy/MM/dd'
                              final dateRegex =
                                  RegExp(r'\d{4}-\d{1,2}-\d{1,2}');
                              if (!dateRegex.hasMatch(value)) {
                                return 'Please enter a valid birthdate in format yyyy-MM-dd';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Birthdate',
                              hintText: 'yyyy-MM-dd',
                              border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            final DateTime? pickedDate = await showDatePicker(
                              context: context,
                              firstDate: DateTime(1900),
                              initialDate: DateTime.now(),
                              lastDate: DateTime.now(),
                            );
                            if (pickedDate != null) {
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                              _birthdate.text = formattedDate;
                            }
                          },
                          child: Icon(Icons.calendar_today),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.0),
                    TextFormField(
                      controller: _password,
                      obscureText: true,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 8) {
                          return 'Please enter a password with at least 8 characters';
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
                  ],
                ),
              ),
              SizedBox(height: 4.0),
              Container(
                width: double.infinity,
                height: 35.0,
                child: OutlinedButton.icon(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        /////test regApi ////
                        final registerAuth = await registerDataFromApi();
                        final dio = Dio();
                        print('registerAuth : $registerAuth');
                        if (registerAuth != null) {
                          print('lol');
                          String fullname = _fullname.text;
                          String username = _username.text;
                          String email = _email.text;
                          String birthdate = _birthdate.text;
                          String password = _password.text;

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
                                    'username': username,
                                    'password': password,
                                  }));

                          print(response.data);
                          print('lloll');

                          setCookie('accesstoken', response.data['access_token']);
                          setCookie('username', username.toString());
                              
                              setCookie('id', registerAuth.toString());
                      
                        final id = getCookie('id');
                          final cookie = getCookie('accesstoken');
                          final usercookie = getCookie('username');
                          // dio.options.headers['Authorization'] =
                          //     'Bearer $registerAuth';

                          // final response =
                          // await dio.post('http://localhost:8000/api/user/register',
                          //     options: Options(
                          //       contentType: 'application/json',
                          //     ),
                          //     data:jsonEncode( ({
                          //       'fullname': fullname,
                          //       'username': username,
                          //       'email': email,
                          //       'birthdate': birthdate,
                          //       'password': password
                          //     }))
                          //     );
                          // print('response: ${response.data}');
                          // print(id);
                          print('lolll');

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
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) {
                              return Splashpage();
                            }),
                          );
                          // if (response.statusCode == 200) {
                          //   final responseRegisterData = response.data;
                          //   print('responseRegisterData: $responseRegisterData');
                          // } else {
                          //   print(
                          //       'Request failed with status: ${response.statusCode}.');
                          // }
                        }
                      } on DioError catch (error) {
                        // Handle the 401 error
                        if (error.response?.statusCode == 401) {
                          print('Error 401: Unauthorized');
                          // You could prompt the user to login again or refresh their token here
                        } else {
                          print(
                              'Error ${error.response?.statusCode}: ${error.message}');
                        }
                      }
                      // Handle login logic here
                      // String email = email.text;
                      // String password = password.text;
                      // Perform authentication logic and handle success/failure
                      // if (_formKey.currentState!.validate()) {
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                      //   print(
                      //       "This Mail is : ${email.text} & password is : ${password.text}");

                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     SnackBar(
                      //       content: Row(
                      //         mainAxisAlignment:
                      //             MainAxisAlignment.center, // Center the content
                      //         children: [
                      //           Icon(Icons.circle_outlined),
                      //           SizedBox(width: 8),
                      //           Text('Loading'),
                      //         ],
                      //       ),
                      //     ),
                      //   );
                      //   Navigator.of(context)
                      //       .push(MaterialPageRoute(builder: (context) {
                      //     return Loginpage();
                      //   }));
                      // }
                    }
                  },
                  icon: Icon(Icons.login, color: Colors.white),
                  label: Text('Sign in', style: TextStyle(color: Colors.white)),
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
              TextButton(
                onPressed: () {
                  // Navigate to loginpage page
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return Loginpage();
                  }));
                },
                child: Text('Have an account already? Log in'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
