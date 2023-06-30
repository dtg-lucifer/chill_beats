import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_playaer/constants/colors.dart';
import 'package:music_playaer/constants/text_styles.dart';
import 'package:music_playaer/controllers/player_controller.dart';
import 'package:music_playaer/screens/playlists/playlist.dart';

class PlaylistListingScreen extends StatefulWidget {
  const PlaylistListingScreen({super.key});

  @override
  State<PlaylistListingScreen> createState() => _PlaylistListingScreenState();
}

class _PlaylistListingScreenState extends State<PlaylistListingScreen> {
  final controller = PlayerController();

  @override
  void initState() {
    super.initState();
  }

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
      floatingActionButton: ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            useSafeArea: true,
            builder: (BuildContext ctx) {
              return Material(
                type: MaterialType.transparency,
                child: Center(
                  child: SizedBox(
                    height: 170,
                    width: 380,
                    child: Container(
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextField(
                              decoration: InputDecoration(
                                hintText: "Enter playlist name",
                                hintStyle: GoogleFonts.poppins(
                                  color: white,
                                  fontSize: 18,
                                ),
                              ),
                              style: GoogleFonts.poppins(
                                color: white,
                                fontSize: 18,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: const Text(
                                    "Cancel",
                                    style: TextStyle(
                                      color: white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: const Text(
                                    "Create",
                                    style: TextStyle(
                                      color: white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
        style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll<Color>(bgColor),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
          child: Icon(
            Icons.my_library_add_outlined,
            color: white,
          ),
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
