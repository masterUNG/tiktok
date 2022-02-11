// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class DataModel {
  final String caption;
  final String commentcount;
  final String id;
  final String likes;
  final String previewimage;
  final String profilepic;
  final String sharecount;
  final String songname;
  final String uid;
  final String username;
  final String videourl;
  DataModel({
    @required this.caption,
    @required this.commentcount,
    @required this.id,
    @required this.likes,
    @required this.previewimage,
    @required this.profilepic,
    @required this.sharecount,
    @required this.songname,
    @required this.uid,
    @required this.username,
    @required this.videourl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'caption': caption,
      'commentcount': commentcount,
      'id': id,
      'likes': likes,
      'previewimage': previewimage,
      'profilepic': profilepic,
      'sharecount': sharecount,
      'songname': songname,
      'uid': uid,
      'username': username,
      'videourl': videourl,
    };
  }

  factory DataModel.fromMap(Map<String, dynamic> map) {
    return DataModel(
      caption: (map['caption'] ?? '') as String,
      commentcount: (map['commentcount'] ?? '') as String,
      id: (map['id'] ?? '') as String,
      likes: (map['likes'] ?? '') as String,
      previewimage: (map['previewimage'] ?? '') as String,
      profilepic: (map['profilepic'] ?? '') as String,
      sharecount: (map['sharecount'] ?? '') as String,
      songname: (map['songname'] ?? '') as String,
      uid: (map['uid'] ?? '') as String,
      username: (map['username'] ?? '') as String,
      videourl: (map['videourl'] ?? '') as String,
    );
  }

  factory DataModel.fromJson(String source) => DataModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
