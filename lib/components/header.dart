import 'package:flutter/material.dart';
import 'package:team_calendar/models/header.dart';

class HeaderComponent extends StatelessWidget {
  final Header header;
  final String name;
  final double height;
  final Color borderColor;

  const HeaderComponent(
      {Key? key,
      required this.header,
      required this.name,
      this.borderColor = const Color(0xFF353433),
      required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(color: borderColor.withOpacity(0.6)),
      )),
      width: 200,
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
            name,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
