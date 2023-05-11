import 'package:flutter/material.dart';

class Notificationpage extends StatefulWidget {
  const Notificationpage({ Key? key }) : super(key: key);

  @override
  _NotificationpageState createState() => _NotificationpageState();
}

class _NotificationpageState extends State<Notificationpage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            toolbarHeight: 0,
            bottom: const TabBar(
              tabs: [
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    'All',
                    style: TextStyle(
                      color: Colors.black
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                  'Verified',
                    style: TextStyle(
                      color: Colors.black
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    'Mentions',
                    style: TextStyle(
                      color: Colors.black
                    ),
                  ),
                )
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.blue,
            child: const Icon(Icons.add, size: 30),
          ),
          body: TabBarView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 200,
                    width: 270,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/twitternotefic.png'),
                      ),
                    ),
                  ),
                    Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                       Text(
                          'Nothing to see here — \nyet',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    
                      SizedBox(
                        height: 10,
                      ),
                    Text(
                          "Likes, mentions, Retweets, and a whole lot more\n — when it comes from a verified account, you'll\n find it here.",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 200,
                    width: 270,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/twitternotefic.png'),
                      ),
                    ),
                  ),
                    Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                       Text(
                          'Nothing to see here — \nyet',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    
                      SizedBox(
                        height: 10,
                      ),
                    Text(
                          "Likes, mentions, Retweets, and a whole lot more \n— when it comes from a verified account, you'll\n find it here.",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 200,
                    width: 270,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/twitternotefic.png'),
                      ),
                    ),
                  ),
                    Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                       Text(
                          'Nothing to see here — \nyet',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    
                      SizedBox(
                        height: 10,
                      ),
                    Text(
                          "Likes, mentions, Retweets, and a whole lot more\n — when it comes from a verified account, you'll \nfind it here.",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                    ],
                  ),
                ],
              )
            ],
          ) ,
        ),
      ),
    );
  }
}