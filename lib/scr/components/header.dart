import 'package:flutter/material.dart';
import 'package:team_calendar/scr/models/header.dart';

class HeaderComponent extends StatelessWidget {
  final Header header;

  final double width;
  final double height;
  final Color borderColor;
  final Color backgroundColor;

  const HeaderComponent({
    Key? key,
    required this.header,
    required this.height,
    required this.width,
    this.backgroundColor = Colors.white,
    this.borderColor = const Color(0xFF353433),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: backgroundColor,
          border: Border(
            bottom: BorderSide(color: borderColor.withOpacity(0.6)),
          )),
      width: width,
      height: height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 4,
            margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
            decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(10)),
          ),
          const SizedBox(width: 5),
          Text(
            header.title,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
