import 'package:flutter/material.dart';
import 'package:twitter_clone/views/pages/homepage.dart';
import 'package:twitter_clone/views/pages/searchpage.dart';
import 'package:twitter_clone/views/pages/massegepage.dart';
import 'package:twitter_clone/views/pages/notificationpage.dart';
import 'package:twitter_clone/views/pages/profilepage.dart';

class Bottombar extends StatefulWidget {
  const Bottombar({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BottombarState createState() => _BottombarState();
}

class _BottombarState extends State<Bottombar> {
  int selectedindex = 0;
  void _onTap(int index) {
    setState(() {
      selectedindex = index;
    });
  }

  static const List<Widget> _widgetOptions = <Widget>[
    Homepage(),
    Searchpage(),
    Profilepage(),
    Notificationpage(),
    Massegepage(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: selectedindex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: _onTap,
        items:const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'engy'
              ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
              ),
              label: 'engy'
              ),
               BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: 'engy'
              ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.notifications,
              ),
              label: 'engy'
              ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.mail,
              ),
              label: 'engy'
              ),
         ],
      ),
       body: _widgetOptions.elementAt(selectedindex)

    );
  }
}
