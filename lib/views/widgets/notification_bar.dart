import 'package:flutter/material.dart';

class NotificationBar extends StatefulWidget {
  final Icon icon;
  final String title;
  final String desc;
  final Color bgColor;

  const NotificationBar({
    Key? key,
    required this.icon,
    required this.title,
    required this.desc,
    required this.bgColor,
  }) : super(key: key);

  @override
  _NotificationBarState createState() => _NotificationBarState();
}

class _NotificationBarState extends State<NotificationBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.bgColor,
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          widget.icon,
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(widget.desc),
            ],
          ),
        ],
      ),
    );
  }
}
