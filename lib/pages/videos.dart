// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_print
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tiktok/models/data_model.dart';
import 'package:tiktok/pages/show_menu_page.dart';
import 'package:tiktok/widgets/show_progress.dart';
import 'package:tiktok/widgets/video_player_item.dart';

import 'package:tiktok/pages/comments.dart';
import 'package:tiktok/utility/finduid.dart';
import 'package:tiktok/variables.dart';
import 'package:tiktok/widgets/circleanimation.dart';

class VideoPage extends StatefulWidget {
  final String uid;
  const VideoPage({
    Key key,
    @required this.uid,
  }) : super(key: key);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  Stream mystream;
  String uid;
  PageController pageController;

  var datamodels = <DataModel>[];

  int indexPage = 0;

  @override
  initState() {
    super.initState();
    //uid = FindUid().loginUid() as String;
    uid = widget.uid;
    mystream = FirebaseFirestore.instance.collection('videos').snapshots();

    pageController = PageController(initialPage: indexPage);

    readDataJson();
  }

  PageController setupPageController(int index) {
    return PageController(initialPage: index, viewportFraction: 1);
  }

  Future<void> readDataJson() async {
    String string = await loadJson();
    var jsonRes = json.decode(string);
    var arrayVideo = jsonRes['videos'];

    print('arrayVideo ==> $arrayVideo');
    for (var item in arrayVideo) {
      DataModel dataModel = DataModel.fromMap(item);
      print('#11feb url ===>> ${dataModel.videourl}');
      setState(() {
        datamodels.add(dataModel);
      });
    }
  }

  Future<String> loadJson() async {
    return await rootBundle.loadString('assets/data.json');
  }

  buildprofile(String url) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Stack(
        children: [
          Positioned(
            left: 5,
            child: Container(
              width: 50,
              height: 50,
              padding: EdgeInsets.all(1),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(25)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image(
                  image: NetworkImage(url),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 20,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                  color: Colors.pink, borderRadius: BorderRadius.circular(15)),
              child: Icon(Icons.add, color: Colors.white, size: 20),
            ),
          )
        ],
      ),
    );
  }

  buildrotatingprofile(String url) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(11),
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              gradient:
                  LinearGradient(colors: [Colors.grey[800], Colors.grey[700]]),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image(
                image: NetworkImage(url),
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      ),
    );
  }

  likevideo(String id) async {
    String uid = FindUid().loginUid() as String;
    DocumentSnapshot doc = await videoscollection.doc(id).get();
    if (doc.data()['likes'].contains(uid)) {
      videoscollection.doc(id).update({
        'likes': FieldValue.arrayRemove([uid])
      });
    } else {
      videoscollection.doc(id).update({
        'likes': FieldValue.arrayUnion([uid])
      });
    }
  }

  sharevideo(String video, String id) async {
    var request = await HttpClient().getUrl(Uri.parse(video));
    var response = await request.close();
    Uint8List bytes = await consolidateHttpClientResponseBytes(response);
    await Share.file('FlikTok', 'Video.mp4', bytes, 'video/mp4');
    DocumentSnapshot doc = await videoscollection.doc(id).get();
    videoscollection
        .doc(id)
        .update({'sharecount': doc.data()['sharecount'] + 1});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: datamodels.isEmpty
          ? const ShowProgress()
          : PageView.builder(
              itemCount: datamodels.length,
              controller: pageController,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onHorizontalDragStart: (details) {
                    // Navigator.pushAndRemoveUntil(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => const ShowMenuPage(),
                    //     ),
                    //     (route) => false);
                    indexPage++;
                    pageController.animateToPage(indexPage,
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.bounceInOut);
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Stack(
                    children: [
                      VideoPlayerItem(indexVideo: index, dataModels: datamodels,),
                      rightMenu(datamodels[index], context),
                    ],
                  ),
                );
              },
            ),
    );
  }

  Column rightMenu(DataModel dataModel, BuildContext context) {
    return Column(
      children: [
        // top section
        SizedBox(
          height: 100,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Following",
                style: mystyle(17, Colors.white, FontWeight.bold),
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                "For you",
                style: mystyle(17, Colors.white, FontWeight.bold),
              )
            ],
          ),
        ),
        // middle section
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // down captions, author , song name
              Expanded(
                  child: Container(
                height: 70,
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(dataModel.username,
                        style: mystyle(15, Colors.white, FontWeight.bold)),
                    Text(
                      dataModel.caption,
                      style: mystyle(15, Colors.white, FontWeight.bold),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.music_note,
                          size: 15,
                          color: Colors.white,
                        ),
                        Text(
                          dataModel.songname,
                          style: mystyle(15, Colors.white, FontWeight.bold),
                        )
                      ],
                    )
                  ],
                ),
              )),
              // right section
              Container(
                width: 100,
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildprofile(dataModel.profilepic),
                    Column(
                      children: [
                        InkWell(
                          onTap: () => likevideo(dataModel.id),
                          child: const Icon(Icons.favorite,
                              size: 55, color: Colors.white),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Text(
                          dataModel.likes.length.toString(),
                          style: mystyle(20, Colors.white),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CommentsPage(dataModel.id))),
                          child: const Icon(Icons.comment,
                              size: 55, color: Colors.white),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Text(
                          dataModel.commentcount.toString(),
                          style: mystyle(20, Colors.white),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        InkWell(
                          onTap: () =>
                              sharevideo(dataModel.videourl, dataModel.id),
                          child: const Icon(Icons.reply,
                              size: 55, color: Colors.white),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Text(
                          dataModel.sharecount.toString(),
                          style: mystyle(20, Colors.white),
                        )
                      ],
                    ),
                    CircleAnimation(buildrotatingprofile(dataModel.profilepic))
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
