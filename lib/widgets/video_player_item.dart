// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_print
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'package:tiktok/models/data_model.dart';

class VideoPlayerItem extends StatefulWidget {
  final int indexVideo;
  final List<DataModel> dataModels;

  const VideoPlayerItem({
    Key key,
    @required this.indexVideo,
    @required this.dataModels,
  }) : super(key: key);
  @override
  _VideoPlayerItemState createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  VideoPlayerController videoPlayerController;
  List<DataModel> dataModels;
  int indexVideo;

  @override
  void initState() {
    super.initState();

    dataModels = widget.dataModels;
    indexVideo = widget.indexVideo;

    videoPlayerController =
        VideoPlayerController.network(dataModels[indexVideo].videourl)
          ..initialize().then((value) {
            videoPlayerController.play();
            videoPlayerController.setVolume(0.1);
          });

    // var myendFunc = widget.endFunc;

    videoPlayerController.addListener(() {
      if (videoPlayerController.value.duration ==
          videoPlayerController.value.position) {
        print('######## video End');

        setState(() {
          if (indexVideo + 1 >= dataModels.length) {
            indexVideo = 0;
          } 
          videoPlayerController =
              VideoPlayerController.network(dataModels[indexVideo + 1].videourl)
                ..initialize().then((value) {
                  videoPlayerController.play();
                  videoPlayerController.setVolume(0.1);
                });
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: VideoPlayer(videoPlayerController),
    );
  }
}
