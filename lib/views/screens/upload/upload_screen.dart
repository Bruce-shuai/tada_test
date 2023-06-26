import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tada_video/controller/upload_video_controller.dart';
import 'package:video_player/video_player.dart';
import '../../../constants/color_constants.dart';
import '../../../constants/type_constants.dart';
import '../../widgets/common_button.dart';
import 'package:image_picker/image_picker.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({Key? key}) : super(key: key);

  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final UploadVideoController uploadVideoController =
      Get.put(UploadVideoController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Container(
          alignment: Alignment.centerLeft,
          child: const Text(
            'Upload TaDa',
            textAlign: TextAlign.left,
          ),
        ),
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/page_close.svg',
            width: 26,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Upload Video',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white)),
          const SizedBox(
            height: 24,
          ),
          const SelectVideo(),
          const SizedBox(
            height: 12,
          ),
          const Text('Add Description',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white)),
          const SizedBox(
            height: 12,
          ),
          Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColor.bgGray, // 背景色
              ),
              child: TextField(
                onChanged: (value) {
                  uploadVideoController.description.value = value;
                },
                maxLines: 10,
                maxLength: 100,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Make your work more exciting', // 显示在输入框中的提示文本
                  hintStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: AppColor.btnGray),
                ),
              )),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                  width: double.infinity,
                  child: CommonButton(
                      text: 'Upload Video',
                      onPressed: () => {
                            // 上传btn
                            uploadVideoController.upload()
                          },
                      btnStyle: CommonBtnStyle.yellowBg,
                      sizeRounded: CommonBtnRoundedSize.medium)),
            ),
          ),
        ]),
      ),
    );
  }
}

class VideoPlayerView extends StatefulWidget {
  const VideoPlayerView(
      {super.key, required this.url, required this.dataSourceType});
  final String url;
  final VideoSourceType dataSourceType;

  @override
  _VideoPlayerViewState createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<VideoPlayerView> {
  late VideoPlayerController _videoPlayerController;

  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();

    switch (widget.dataSourceType) {
      case VideoSourceType.asset:
        _videoPlayerController = VideoPlayerController.asset(widget.url);
        break;
      case VideoSourceType.network:
        _videoPlayerController = VideoPlayerController.network(widget.url);
        break;
      case VideoSourceType.file:
        _videoPlayerController = VideoPlayerController.file(File(widget.url));
        break;
      case VideoSourceType.contentUri:
        _videoPlayerController = VideoPlayerController.network(widget.url);
        break;
    }

    _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController, aspectRatio: 16 / 9);
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColor.bgGray, // 背景色
        ),
        child: AspectRatio(
          aspectRatio: 19 / 9,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Chewie(
                controller: _chewieController,
              )),
        ));
  }
}

class SelectVideo extends StatefulWidget {
  const SelectVideo({Key? key}) : super(key: key);

  @override
  _SelectVideoState createState() => _SelectVideoState();
}

class _SelectVideoState extends State<SelectVideo> {
  final UploadVideoController uploadVideoController =
      Get.find<UploadVideoController>();
  @override
  Widget build(BuildContext context) {
    final xfile = uploadVideoController.video.value;
    return Column(
      children: [
        if (xfile == null)
          GestureDetector(
            onTap: () async {
              final file = await ImagePicker().pickVideo(
                source: ImageSource.gallery,
              );
              if (file != null) {
                setState(() {
                  uploadVideoController.video.value = XFile(file.path);
                });
              }
            },
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColor.bgGray, // 背景色
              ),
              child: AspectRatio(
                aspectRatio: 19 / 9,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.videocam_outlined, // 中间的 Icon
                      size: 50.0,
                      color: AppColor.btnGray,
                    ),
                    const SizedBox(height: 4),
                    Text('Upload Video From Gallery', // 中间的文字
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            color: AppColor.btnGray)),
                  ],
                ),
              ),
            ),
          ),
        if (xfile != null)
          VideoPlayerView(
              url: xfile!.path, dataSourceType: VideoSourceType.file)
      ],
    );
  }
}
