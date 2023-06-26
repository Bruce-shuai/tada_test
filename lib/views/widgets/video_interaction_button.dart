import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils.dart';

class VideoInteractionButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String iconSvgPath;
  final String? iconClickedSvgPath;
  final int count;
  const VideoInteractionButton({
    Key? key,
    required this.count,
    required this.onPressed,
    required this.iconSvgPath,
    this.iconClickedSvgPath,
  }) : super(key: key);

  @override
  _VideoInteractionButtonState createState() => _VideoInteractionButtonState();
}

class _VideoInteractionButtonState extends State<VideoInteractionButton> {
  bool _isClicked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onPressed();
        setState(() {
          _isClicked = !_isClicked;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            _isClicked
                ? widget.iconClickedSvgPath ?? widget.iconSvgPath
                : widget.iconSvgPath,
            height: 42.0,
            width: 42.0,
          ),
          const SizedBox(height: 4.0),
          Text(
            formatNumber(widget.count),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
