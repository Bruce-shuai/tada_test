import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tada_video/constants/route_constants.dart';

class ProfileSettingScreen extends StatefulWidget {
  const ProfileSettingScreen({Key? key}) : super(key: key);

  @override
  _ProfileSettingScreenState createState() => _ProfileSettingScreenState();
}

class _ProfileSettingScreenState extends State<ProfileSettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Container(
          alignment: Alignment.centerLeft,
          child: const Text(
            'Settings',
            textAlign: TextAlign.left,
          ),
        ),
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
      body: ListView(
        children: [
          _tile('Feedback', 'assets/setting_feedback.svg',
              Icons.arrow_forward_ios_rounded,
              targetPage: Routes.profileFeedback),
          _tile('Privacy Policy', 'assets/setting_about.svg',
              Icons.arrow_forward_ios_rounded),
          _tile('Term of Use', 'assets/setting_term.svg',
              Icons.arrow_forward_ios_rounded),
          _tile('About', 'assets/setting_about.svg',
              Icons.arrow_forward_ios_rounded),
        ],
      ),
    );
  }

  ListTile _tile(String title, String leftIcon, IconData rightIcon,
      {String? targetPage}) {
    return ListTile(
      title: Text(title),
      leading: SvgPicture.asset(leftIcon),
      trailing: Icon(rightIcon),
      onTap: () {
        if (targetPage != null) {
          print('targetPage: $targetPage');
          Get.toNamed(targetPage);
        }
      },
    );
  }
}
