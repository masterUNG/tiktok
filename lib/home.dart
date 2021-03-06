// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tiktok/pages/addvideo.dart';
import 'package:tiktok/pages/messages.dart';
import 'package:tiktok/pages/profile.dart';
import 'package:tiktok/pages/search.dart';
import 'package:tiktok/pages/videos.dart';
import 'package:tiktok/utility/finduid.dart';
import 'package:tiktok/variables.dart';
import 'package:tiktok/widgets/show_progress.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var pageoptions = <Widget>[];
  bool load = true;

  int page = 0;

  String uidLogin;

  customicon() {
    return Container(
      width: 45,
      height: 27,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(left: 10),
            width: 38,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 250, 45, 108),
                borderRadius: BorderRadius.circular(7)),
          ),
          Container(
            margin: EdgeInsets.only(right: 10),
            width: 38,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 32, 211, 234),
                borderRadius: BorderRadius.circular(7)),
          ),
          Center(
            child: Container(
              height: double.infinity,
              width: 38,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(7),
              ),
              child: Icon(Icons.add, size: 20),
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    setupPageOption();
  }

  Future<void> setupPageOption() async {
    await FindUid().loginUid().then((value) {
      setState(() {
        load = false;
      });
      print('uidLogin = $uidLogin');

      pageoptions.add(VideoPage(uid: uidLogin,));
      // pageoptions.add(Text('Test'));
      pageoptions.add(SearchPage());
      pageoptions.add(AddVideoPage());
      pageoptions.add(Messages());
      pageoptions.add(ProfilePage(uidLogin));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: load ? const ShowProgress() : pageoptions[page],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            page = index;
          });
        },
        selectedItemColor: Colors.lightBlue,
        unselectedItemColor: Colors.black,
        currentIndex: page,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 30),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.search, size: 30),
              label: "Search"),
          BottomNavigationBarItem(
              icon: customicon(),
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.message, size: 30),
              label:"Messages"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 30),
              label: "Profile")
        ],
      ),
    );
  }
}
