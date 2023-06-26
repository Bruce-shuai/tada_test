import 'package:flutter/material.dart';
import '../../constants/color_constants.dart';
import '../../constants/type_constants.dart';

class CommonButton extends StatelessWidget {
  final VoidCallback onPressed;
  final CommonBtnRoundedSize sizeRounded;
  final CommonBtnStyle btnStyle;
  final String text;
  const CommonButton(
      {Key? key,
      this.sizeRounded = CommonBtnRoundedSize.small,
      this.btnStyle = CommonBtnStyle.yellowBg,
      required this.text,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Determine button border and background color based on button style and rounded size
    Color bgColor;
    Color borderColor;
    Color textColor;
    switch (btnStyle) {
      case CommonBtnStyle.outline:
        bgColor = Colors.transparent;
        borderColor = Colors.black;
        textColor = Colors.white70;
        break;
      case CommonBtnStyle.grayBg:
        bgColor = Colors.grey;
        borderColor = Colors.transparent;
        textColor = Colors.white70;
        break;
      case CommonBtnStyle.yellowBg:
      default:
        bgColor = AppColor.btnYellow;
        borderColor = Colors.transparent;
        textColor = Colors.black;
        break;
    }

    // Determine button border radius based on rounded size
    double borderRadius;
    switch (sizeRounded) {
      case CommonBtnRoundedSize.small:
        borderRadius = 16.0;
        break;
      case CommonBtnRoundedSize.medium:
        borderRadius = 100.0;
        break;
    }
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(bgColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: BorderSide(
              color: borderColor,
              width: 2.0,
            ),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
