import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_playaer/constants/colors.dart';
import 'package:music_playaer/constants/text_styles.dart';
import 'package:music_playaer/screens/playlists/playlist.dart';

class PlaylistListingScreen extends StatefulWidget {
  const PlaylistListingScreen({super.key});

  @override
  State<PlaylistListingScreen> createState() => _PlaylistListingScreenState();
}

class _PlaylistListingScreenState extends State<PlaylistListingScreen> {
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
          'Your playlists',
          style: textStyle(size: 28.0, weight: FontWeight.w800),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(
                Icons.library_music_outlined,
                color: white,
              ),
              title: const Text(
                "Playlist One",
                style: TextStyle(
                  color: white,
                  fontSize: 18,
                ),
              ),
              onTap: () {
                Get.to(() => const PlayList(name: "Playlist One"));
              },
            ),
          ],
        ),
      ),
    );
  }
}
