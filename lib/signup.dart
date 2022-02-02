import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tiktok/home.dart';
import 'package:tiktok/models/user_model.dart';
import 'package:tiktok/policy.dart';
import 'package:tiktok/variables.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController usernamecontroller = TextEditingController();

  Future<void> registeruser() async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: emailcontroller.text, password: passwordcontroller.text)
        .then((value) async {
      value.user.updateProfile(
        displayName: usernamecontroller.text,
        photoURL:
            'https://www.accountingweb.co.uk/sites/all/modules/custom/sm_pp_user_profile/img/default-user.png',
      );

      UserModel userModel = UserModel(
        username: usernamecontroller.text,
        password: passwordcontroller.text,
        email: emailcontroller.text,
        uid: value.user.uid,
        profilepic:
            'https://www.accountingweb.co.uk/sites/all/modules/custom/sm_pp_user_profile/img/default-user.png',
      );

      await FirebaseFirestore.instance
          .collection('user')
          .doc(value.user.uid)
          .set(userModel.toMap())
          .then((value) => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
              (route) => false));

    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[200],
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Lets goooo",
                style: mystyle(25, Colors.black, FontWeight.w600)),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Register",
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
                controller: usernamecontroller,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    labelText: 'Username',
                    prefixIcon: Icon(Icons.person),
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
                    prefixIcon: Icon(Icons.lock),
                    labelStyle: mystyle(20),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () => registeruser(),
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: Text(
                    "Register",
                    style: mystyle(20, Colors.white, FontWeight.w700),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "I agree to",
                  style: mystyle(20),
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TermsofPolicy())),
                  child: Text(
                    "Terms of policy",
                    style: mystyle(20, Colors.purple),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
