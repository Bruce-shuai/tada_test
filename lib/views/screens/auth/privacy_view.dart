import 'package:flutter/material.dart';
import 'package:tada_video/constants/color_constants.dart';

class PrivacyView extends StatelessWidget {
  const PrivacyView({Key? key}) : super(key: key);

  enPrivacy() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text('Privacy Policy',
            style: TextStyle(color: Colors.blue, fontSize: 14)),
        SizedBox(
          width: 4,
        ),
        Text('|', style: TextStyle(color: Colors.white)),
        SizedBox(
          width: 4,
        ),
        Text('Terms of Use',
            style: TextStyle(color: Colors.blue, fontSize: 14)),
      ],
    );
  }

  zhPrivacy() {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Agreement(),
          RichText(
              text: const TextSpan(
                  text: '我已阅读并同意',
                  style: TextStyle(color: Colors.grey, fontSize: 10),
                  children: [
                TextSpan(
                  text: '《用户协议》',
                  style: TextStyle(color: Colors.blue),
                ),
                TextSpan(
                  text: '和',
                ),
                TextSpan(
                  text: '《隐私政策》',
                  style: TextStyle(color: Colors.blue),
                ),
                TextSpan(
                  text: '《儿童/青少年个人信息保护规则》',
                  style: TextStyle(color: Colors.blue),
                ),
              ])),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [const AgreementDialog(), zhPrivacy()],
    );
  }
}

class Agreement extends StatefulWidget {
  const Agreement({Key? key}) : super(key: key);

  @override
  _AgreementState createState() => _AgreementState();
}

class _AgreementState extends State<Agreement> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return AppColor.btnYellow;
    }

    return SizedBox(
      width: 30,
      child: Transform.scale(
        scale: 0.8,
        child: Checkbox(
          checkColor: Colors.black,
          shape: const CircleBorder(),
          fillColor: MaterialStateProperty.resolveWith(getColor),
          value: isChecked,
          onChanged: (bool? value) {
            setState(() {
              isChecked = value!;
            });
          },
        ),
      ),
    );
  }
}

class AgreementDialog extends StatelessWidget {
  const AgreementDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text('showModalBottomSheet'),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (BuildContext context) {
            return Container(
              height: 213,
              decoration: BoxDecoration(
                color: AppColor.bgGray,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(48.0),
                  topRight: Radius.circular(48.0),
                ),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        '请阅读并同意一下条款',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w800),
                      ),
                      RichText(
                          text: const TextSpan(
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 10),
                              children: [
                            TextSpan(
                              text: '《用户协议》',
                            ),
                            TextSpan(
                              text: '和',
                            ),
                            TextSpan(
                              text: '《隐私政策》',
                            ),
                            TextSpan(
                              text: '《儿童/青少年个人信息保护规则》',
                            ),
                          ])),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          backgroundColor: AppColor.btnYellow, // 设置背景颜色
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20), // 设置圆角
                          ),
                        ),
                        child: const Text(
                          '同意并继续',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
