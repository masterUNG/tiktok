import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerItem extends StatefulWidget {
  final String videourl;
  final void Function() endFunc;
  const VideoPlayerItem(this.videourl, this.endFunc, {Key key})
      : super(key: key);
  @override
  _VideoPlayerItemState createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  VideoPlayerController videoPlayerController;

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.network(widget.videourl)
      ..initialize().then((value) {
        videoPlayerController.play();
        videoPlayerController.setVolume(0.1);
      });

    // var myendFunc = widget.endFunc;

    videoPlayerController.addListener(() {
      if (videoPlayerController.value.duration ==
          videoPlayerController.value.position) {
        print('######## video End');
        widget.endFunc;
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
