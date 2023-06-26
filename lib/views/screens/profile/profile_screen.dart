import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../constants/color_constants.dart';
import '../../../constants/route_constants.dart';
import '../../../controller/profile_controller.dart';
import '../../../utils.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final ProfileController _controller = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    _controller.getUploadVideos(0, 5);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              'Profile',
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
          actions: [
            IconButton(
              onPressed: () {
                Get.toNamed(Routes.profileSettings);
              },
              icon: SvgPicture.asset(
                'assets/app_setting.svg',
                width: 26,
              ),
            ),
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        const CircleAvatar(
                          radius: 60.0,
                          backgroundImage:
                              AssetImage('assets/default_avatar.png'),
                        ),
                        Positioned(
                          bottom: -8,
                          right: -8,
                          child: IconButton(
                            onPressed: () {},
                            icon: SvgPicture.asset(
                              'assets/avatar_edit.svg',
                              width: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    const EditNameText(
                      text: 'Sander He',
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Expanded(
                      child: DefaultTabController(
                        length: 2, // 2 表示选项卡数量
                        child: Column(
                          children: [
                            TabBar(
                              // 设置选项卡的外观
                              labelColor: AppColor.btnYellow,
                              indicatorColor: AppColor.btnYellow,
                              labelStyle: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                              unselectedLabelColor: Colors.grey,
                              tabs: const [
                                Tab(text: 'My Upload'),
                                Tab(text: 'Draft'),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            // 添加 TabBarView 显示选项卡的内容
                            Expanded(
                              child: TabBarView(
                                children: [
                                  // 这里是第一个选项卡的内容
                                  Obx(() => VideoList(
                                        videoItems: _controller.uploadVideos
                                            .map((video) => VideoItem(
                                                  imageUrl: video['posterUrl']!,
                                                  videoUrl: video['videoUrl']!,
                                                ))
                                            .toList(),
                                      )),
                                  // 这里是第二个选项卡的内容
                                  const VideoList(videoItems: []),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
            )));
  }
}

class EditNameText extends StatefulWidget {
  final String text;

  const EditNameText({Key? key, required this.text}) : super(key: key);

  @override
  _EditNameTextState createState() => _EditNameTextState();
}

class _EditNameTextState extends State<EditNameText> {
  late bool _isEditing;
  late TextEditingController _editingController;

  @override
  void initState() {
    super.initState();
    _isEditing = false;
    _editingController = TextEditingController(text: widget.text);
  }

  @override
  Widget build(BuildContext context) {
    if (_isEditing) {
      return Center(
          child: Transform.translate(
        offset: const Offset(0, -12),
        child: SizedBox(
          width: 140,
          child: TextField(
            controller: _editingController,
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            onSubmitted: (_) {
              setState(() {
                _isEditing = false;
                _editingController.text = _editingController.text;
              });
            },
          ),
        ),
      ));
    } else {
      return GestureDetector(
        onDoubleTap: () {
          setState(() {
            _isEditing = true;
          });
        },
        child: Text(
          widget.text,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
      );
    }
  }
}

class VideoItem extends StatelessWidget {
  final String imageUrl;
  final String videoUrl;
  final String? views;

  const VideoItem({
    Key? key,
    required this.imageUrl,
    required this.videoUrl,
    this.views,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.home, arguments: videoUrl);
      },
      child: Stack(
        children: [
          AspectRatio(
            aspectRatio: 1 / 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          if (views != null)
            Positioned(
              left: 10,
              bottom: 10,
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(
                      fontSize: 9.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                  children: <TextSpan>[
                    TextSpan(text: views, style: const TextStyle(fontSize: 11)),
                    const TextSpan(text: ' views'),
                  ],
                ),
              ),
            ),
          Positioned(
            right: -6,
            bottom: -6,
            child: IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                'assets/upload_video_delete.svg',
                width: 18,
                height: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VideoList extends StatelessWidget {
  final List<VideoItem> videoItems;

  const VideoList({Key? key, required this.videoItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3, // 列数
      crossAxisSpacing: 10.0, // 列间距
      mainAxisSpacing: 10.0, // 行间距
      children: videoItems.map((item) => item).toList(),
    );
  }
}
