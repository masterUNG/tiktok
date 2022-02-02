// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class UserModel {
  final String username;
  final String password;
  final String email;
  final String uid;
  final String profilepic;
  UserModel({
     @required this.username,
     @required this.password,
     @required this.email,
     @required this.uid,
     @required this.profilepic,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'password': password,
      'email': email,
      'uid': uid,
      'profilepic': profilepic,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      username: (map['username'] ?? '') as String,
      password: (map['password'] ?? '') as String,
      email: (map['email'] ?? '') as String,
      uid: (map['uid'] ?? '') as String,
      profilepic: (map['profilepic'] ?? '') as String,
    );
  }

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
