import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tada_video/models/video.dart';
import 'package:tada_video/views/widgets/video_interaction_button.dart';
import '../../../constants/type_constants.dart';
import '../../../constants/route_constants.dart';
import '../../../controller/video_controller.dart';
import '../../widgets/video_player_item.dart';
import 'creator_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class VideoScreen extends StatefulWidget {
  final String? videoUrlFromProfile;
  const VideoScreen({Key? key, this.videoUrlFromProfile}) : super(key: key);

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  final VideoController _videoController = Get.find();

  @override
  void initState() {
    super.initState();
    _getVideoList();
  }

  Future<void> _getVideoList() async {
    try {
      print('aaassdd');
      final mediaIds = await _videoController.getMediaContentList(10);
      print(mediaIds);
      final videoList = <Video>[];
      for (final mediaId in mediaIds) {
        final video = await _videoController.getMediaInfo(mediaId);
        print(video);
        videoList.add(video);
      }
      _videoController.setVideoList(videoList);
      print(jsonEncode(videoList));
    } catch (e) {
      print('Error getting video list: $e');
    }
  }

  /// creator profile
  buildProfile(String profilePhoto) {
    return GestureDetector(
      onTap: () {
        // 导航到新页面
        Get.toNamed(Routes.creator);
      },
      child: Stack(
        children: [
          CircleAvatar(
            radius: 24.0,
            backgroundImage: AssetImage(profilePhoto),
          ),
          Positioned(
              right: 0,
              bottom: 0,
              child: SvgPicture.asset('assets/creator_subscribe.svg'))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Obx(() {
      final videoList = _videoController.videoList;
      // print(videoList);
      if (videoList.isEmpty) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return PageView.builder(
            itemCount: videoList.length,
            controller: PageController(initialPage: 0, viewportFraction: 1),
            scrollDirection: Axis.vertical,
            itemBuilder: (_, int index) {
              return Stack(
                children: [
                  // Video Player
                  VideoPlayerItem(
                    videoUrl: widget.videoUrlFromProfile != null
                        ? widget.videoUrlFromProfile!
                        : videoList[index].videoUrl,
                  ),

                  const Positioned(
                    top: 60,
                    left: 28,
                    child: MoreButton(),
                  ),
                  // Bottom video introduction
                  Positioned(
                    left: 0,
                    bottom: 0,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: SizedBox(
                        width: size.width * 0.8,
                        height: size.height * 0.08,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              videoList[index].caption,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // 右侧的操作按钮
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Padding(
                      padding: EdgeInsets.only(
                          right: 12.0, bottom: size.height * 0.04),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          buildProfile('assets/default_avatar.png'),
                          const SizedBox(height: 24),
                          VideoInteractionButton(
                              count: videoList[index].likes,
                              onPressed: () => {
                                    // 点赞请求
                                  },
                              iconSvgPath: 'assets/like.svg',
                              iconClickedSvgPath: 'assets/like_clicked.svg'),
                          const SizedBox(height: 6),
                          const SizedBox(height: 24),
                          VideoInteractionButton(
                            count: videoList[index].shares,
                            onPressed: () => {
                              // 分享请求
                            },
                            iconSvgPath: 'assets/share.svg',
                          ),
                          const SizedBox(height: 6),
                          const SizedBox(height: 6),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            });
      }
    });
  }
}

class MoreButton extends StatelessWidget {
  const MoreButton({Key? key}) : super(key: key);

  // String _selectedItem;
  void _showPopupMenu(BuildContext context) async {
    final selected = await showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(40, 100, 40, 50),
      constraints: const BoxConstraints(maxWidth: 180),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),

      // 菜单的弹出位置
      items: <PopupMenuEntry<String>>[
        PopupMenuItem(
          value: 'menu1',
          child: Row(
            children: [
              SvgPicture.asset('assets/more_ban.svg'),
              const SizedBox(width: 6),
              const Text(
                'Band This Video',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
        const PopupMenuDivider(
          height: 10,
        ),
        PopupMenuItem(
          value: 'menu2',
          child: Row(
            children: [
              SvgPicture.asset('assets/more_report.svg'),
              const SizedBox(width: 6),
              const Text(
                'Report This Video',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ],
      elevation: 8.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => {
              _showPopupMenu(context),
            },
        icon: SvgPicture.asset('assets/more.svg'));
  }
}
