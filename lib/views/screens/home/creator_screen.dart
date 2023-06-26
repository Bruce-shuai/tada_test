import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tada_video/constants/color_constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils.dart';

class CreatorScreen extends StatefulWidget {
  const CreatorScreen({Key? key}) : super(key: key);

  @override
  _CreatorScreenState createState() => _CreatorScreenState();
}

class _CreatorScreenState extends State<CreatorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/page_back.svg',
            width: 26,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: ListView(
            children: [
              // Avatar and Subscribe
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Avatar
                  const CircleAvatar(
                    radius: 60.0,
                    backgroundImage: AssetImage('assets/default_avatar.png'),
                  ),
                  const SizedBox(height: 12),
                  // Name
                  const Text('Sander He',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      )),
                  const SizedBox(height: 12),
                  // Subscribe
                  ElevatedButton(
                    child: Text("Subscribe"),
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.btnYellow, // 设置背景颜色
                      foregroundColor: Colors.black, // 设置前景颜色
                      minimumSize: const Size(113, 38),
                      textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30), // 设置圆角半径
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Followers
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('2.5M'),
                        SizedBox(width: 4),
                        Text('Followers'),
                        Text(' · '),
                        Text('267'),
                        SizedBox(width: 4),
                        Text('Tabs')
                      ]),
                  const SizedBox(height: 23),
                  Divider(
                    height: 2,
                    color: Colors.grey[400],
                  ),
                ],
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: 10,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 19 / 28,
                    ),
                    itemBuilder: (context, index) {
                      return VideoItem(
                          imageUrl: 'assets/video_item_cover.png',
                          views: formatNumber(99999),
                          videoInfo:
                              'Lorem ipsum dolor sit amet, consectetur adectetur adip dolor sit amet, consecteip dolor sit amet, consectetur adip');
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VideoItem extends StatelessWidget {
  final String imageUrl;
  final String videoInfo;
  final String views;

  const VideoItem(
      {Key? key,
      required this.imageUrl,
      required this.views,
      required this.videoInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Image.asset(
            height: double.infinity,
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 30,
          left: 10,
          child: ConstrainedBox(
              // 使用 ConstrainedBox 限制 Text 组件的宽度
              constraints: BoxConstraints(
                maxWidth:
                    MediaQuery.of(context).size.width / 2.4, // 最大宽度为屏幕 1 / 2.5
                minWidth: 0, // 最小宽度为 0
              ),
              child: Text(
                videoInfo,
                maxLines: 2,
                overflow: TextOverflow.ellipsis, // 超出部分用省略号表示
              )),
        ),
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
      ],
    );
  }
}
