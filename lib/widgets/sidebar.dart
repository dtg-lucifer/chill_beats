import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_playaer/constants/colors.dart';
import 'package:music_playaer/screens/favourites.dart';
import 'package:music_playaer/screens/playlists/listing.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: bgColor,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
          child: ListView(
            children: [
              const ListTile(
                title: Text(
                  "Chill Beats",
                  style: TextStyle(
                    color: white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 36,
              ),
              ListTile(
                leading: const Icon(
                  Icons.favorite_border_rounded,
                  color: white,
                ),
                title: const Text(
                  "Favourites",
                  style: TextStyle(
                    color: white,
                    fontSize: 18,
                  ),
                ),
                onTap: () {
                  Get.to(() => const FavouritesScreen());
                },
              ),
              const SizedBox(
                height: 10.0,
              ),
              ListTile(
                leading: const Icon(
                  Icons.library_music_outlined,
                  color: white,
                ),
                title: const Text(
                  "Playlists",
                  style: TextStyle(
                    color: white,
                    fontSize: 18,
                  ),
                ),
                onTap: () {
                  Get.to(() => const PlaylistListingScreen());
                },
              ),
              const SizedBox(
                height: 10.0,
              ),
              ListTile(
                leading: const Icon(
                  Icons.queue_music_rounded,
                  color: white,
                ),
                title: const Text(
                  "Queue",
                  style: TextStyle(
                    color: white,
                    fontSize: 18,
                  ),
                ),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isDismissible: true,
                    backgroundColor: bgColor,
                    builder: (BuildContext ctx) {
                      return const SizedBox(
                        height: 400,
                        width: double.infinity,
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Queue here",
                                style: TextStyle(fontSize: 24.0, color: white),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
