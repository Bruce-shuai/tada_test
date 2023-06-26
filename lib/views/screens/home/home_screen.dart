import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tada_video/constants/route_constants.dart';
import 'package:video_player/video_player.dart';
import '../../../constants/color_constants.dart';
import '../../../controller/video_controller.dart';
import 'video_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final VideoController _videoController = Get.put(VideoController());
  bool _isPlaying = false;
  @override
  void initState() {
    super.initState();
    _videoController.videoPlayerController?.addListener(_videoPlayerListener);
  }

  @override
  void dispose() {
    _videoController.videoPlayerController
        ?.removeListener(_videoPlayerListener);
    super.dispose();
  }

  void _videoPlayerListener() {
    // 视频播放状态改变后，更新变量 _isPlaying，
    // 视频播放/暂停在 onTap 方法中切换路由时已经处理了，无需在此重复处理
    if (_videoController.videoPlayerController?.value.isPlaying ?? false) {
      setState(() {
        _isPlaying = true;
      });
    } else {
      setState(() {
        _isPlaying = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;
    String? videoUrl;
    if (args != null) {
      videoUrl = args;
    } else {
      videoUrl = null;
    }
    return Scaffold(
      bottomNavigationBar: Container(
          height: 96,
          child: BottomNavigationBar(
            unselectedFontSize: 10,
            selectedFontSize: 10,
            onTap: (idx) {
              if (idx == 1) {
                Get.toNamed(Routes.upload)?.then((value) {
                  // 切换回首页后检查视频播放状态，如需要则继续播放
                  bool shouldPlay = _isPlaying;
                  setState(() {
                    _isPlaying = false;
                  });
                  if (shouldPlay) {
                    _videoController.videoPlayerController?.play();
                  }
                });
                // 暂停视频播放
                _isPlaying =
                    _videoController.videoPlayerController?.value.isPlaying ??
                        false;
                _videoController.videoPlayerController?.pause();
              } else if (idx == 2) {
                // 切换到个人资料路由
                Get.toNamed(Routes.profile)?.then((value) {
                  // 切换回首页后检查视频播放状态，如需要则继续播放
                  bool shouldPlay = _isPlaying;
                  setState(() {
                    _isPlaying = false;
                  });
                  if (shouldPlay) {
                    _videoController.videoPlayerController?.play();
                  }
                });
                // 暂停视频播放
                _isPlaying =
                    _videoController.videoPlayerController?.value.isPlaying ??
                        false;
                _videoController.videoPlayerController?.pause();
              }
            },
            backgroundColor: AppColor.bgOpacity,
            selectedItemColor: Colors.yellow,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/TaDa.svg',
                  width: 24,
                ),
                label: 'TaDa',
                activeIcon: SvgPicture.asset(
                  'assets/TaDa_selected.svg',
                  width: 24,
                ),
              ),
              BottomNavigationBarItem(
                icon: Transform.translate(
                  offset: const Offset(0, 4), // 调整 Y 轴的偏移量来下移 icon
                  child: SvgPicture.asset(
                    'assets/create.svg',
                    width: 40,
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/me.svg',
                  width: 24,
                ),
                label: 'Me',
                activeIcon: SvgPicture.asset(
                  'assets/me_selected.svg',
                  width: 24,
                ),
              ),
            ],
          )),
      body: VideoScreen(
        videoUrlFromProfile: videoUrl,
      ),
    );
  }
}
