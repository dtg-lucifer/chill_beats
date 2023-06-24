import 'package:flutter/material.dart';
import 'package:music_playaer/constants/colors.dart';
import 'package:music_playaer/constants/text_styles.dart';

class PlayList extends StatefulWidget {
  final String name;
  const PlayList({super.key, required this.name});

  @override
  State<PlayList> createState() => _PlayListState();
}

class _PlayListState extends State<PlayList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgDarkClr,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: white),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search_rounded,
              size: 30.0,
            ),
            color: white,
          )
        ],
        title: Text(
          widget.name,
          style: textStyle(size: 28.0, weight: FontWeight.w800),
        ),
      ),
    );
  }
}
