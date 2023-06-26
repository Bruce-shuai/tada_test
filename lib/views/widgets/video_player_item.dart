import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../controller/video_controller.dart';

class VideoPlayerItem extends StatefulWidget {
  final String videoUrl;
  const VideoPlayerItem({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _VideoPlayerItemState createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  late final VideoPlayerController videoPlayerController;
  final VideoController _videoController = Get.find();
  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.network(widget.videoUrl);
    videoPlayerController.initialize().then((value) {
      videoPlayerController.play();
      videoPlayerController.setVolume(1);
      _videoController.setVideoPlayerController(videoPlayerController);
    });
  }

  // 释放资源
  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
    _videoController.setVideoPlayerController(null);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Flexible(
        child: AspectRatio(
          aspectRatio:
              _videoController.videoPlayerController?.value.aspectRatio ??
                  16 / 9,
          child: VideoPlayer(videoPlayerController),
        ),
      ),
    );
  }
}
