// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tiktok/home.dart';
import 'package:tiktok/signup.dart';
import 'package:tiktok/utility/my_dialog.dart';
import 'package:tiktok/variables.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[200],
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome to TikTok",
                style: mystyle(25, Colors.black, FontWeight.w600)),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Login",
              style: mystyle(25, Colors.black, FontWeight.w600),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                controller: emailcontroller,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    labelText: 'Email',
                    prefixIcon: const Icon(Icons.email),
                    labelStyle: mystyle(20),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                controller: passwordcontroller,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                    labelStyle: mystyle(20),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            newLogin(context),
            const SizedBox(
              height: 10,
            ),
            newRegister(context)
          ],
        ),
      ),
    );
  }

  InkWell newLogin(BuildContext context) {
    return InkWell(
      onTap: () async {
        try {
          var email = emailcontroller.text;
          var password = passwordcontroller.text;
          print('email = $email, password = $password');

          await Firebase.initializeApp().then((value) async {
            await FirebaseAuth.instance
                .signInWithEmailAndPassword(email: email, password: password)
                .then((value) {
              print('Login Success');
              // Navigator.pushAndRemoveUntil(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => HomePage(),
              //     ),
              //     (route) => false);
            });
          }).catchError((error) {
            MyDialog(context: context).normalDialog(error.code, error.message);
          });

          // FirebaseAuth.instance.signInWithEmailAndPassword(
          //     email: emailcontroller.text,
          //     password: passwordcontroller.text);
        } catch (e) {
          // SnackBar snackBar = const SnackBar(
          //     content: Text("Try again, email or password are wrong"));
          // Scaffold.of(context).showSnackBar(snackBar);
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 2,
        height: 50,
        decoration: BoxDecoration(
            color: Colors.red, borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: Text(
            "Login",
            style: mystyle(20, Colors.white, FontWeight.w700),
          ),
        ),
      ),
    );
  }

  Row newRegister(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account?",
          style: mystyle(20),
        ),
        const SizedBox(
          width: 10,
        ),
        InkWell(
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => SignUp())),
          child: Text(
            "Register",
            style: mystyle(20, Colors.purple),
          ),
        ),
      ],
    );
  }
}
