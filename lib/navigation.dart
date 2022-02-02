import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tiktok/home.dart';
import 'package:tiktok/pages/login.dart';
import 'package:tiktok/signup.dart';
import 'package:tiktok/utility/finduid.dart';
import 'package:tiktok/variables.dart';

class NavigationPage extends StatefulWidget {
  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  bool isSigned = false;
  initState() {
    super.initState();
  }

  Future<void> checkLogin() async {
    var user = FindUid().loginUid();
    if (user != null) {
      setState(() {
        isSigned = true;
      });
    } else {
      setState(() {
        isSigned = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: isSigned == false ? Login() : HomePage());
  }
}
