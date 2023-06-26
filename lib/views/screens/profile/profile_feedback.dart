import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../constants/color_constants.dart';
import '../../../constants/type_constants.dart';
import '../../widgets/common_button.dart';

class ProfileFeedback extends StatelessWidget {
  const ProfileFeedback({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.bgBlack,
          elevation: 0,
          title: Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              'Feedback',
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
        body: Container(
          color: AppColor.bgBlack,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: AppColor.bgGray, // 背景色
                  ),
                  child: TextField(
                    onChanged: (value) {},
                    maxLines: 10,
                    maxLength: 200,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Anything want us to know', // 显示在输入框中的提示文本
                      hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          color: AppColor.btnGray),
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                        width: double.infinity,
                        child: CommonButton(
                            text: 'Send',
                            onPressed: () => {},
                            btnStyle: CommonBtnStyle.yellowBg,
                            sizeRounded: CommonBtnRoundedSize.medium)),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
