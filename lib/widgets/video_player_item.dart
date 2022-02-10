import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerItem extends StatefulWidget {
  final String videourl;
  const VideoPlayerItem(this.videourl, {Key key}) : super(key: key);
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
        videoPlayerController.setVolume(0.25);
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
