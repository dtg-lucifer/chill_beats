import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_playaer/constants/colors.dart';
import 'package:music_playaer/constants/text_styles.dart';
import 'package:music_playaer/controllers/player_controller.dart';
import 'package:music_playaer/screens/player.dart';
import 'package:music_playaer/widgets/sidebar.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(PlayerController());

    return Scaffold(
      backgroundColor: bgDarkClr,
      drawerScrimColor: bgDarkClr,
      drawer: const SideBar(),
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
          title: Text('Chill Beats',
              style: textStyle(size: 28.0, weight: FontWeight.w800))),
      body: FutureBuilder<List<SongModel>>(
        future: controller.audioQuery.querySongs(
            ignoreCase: true,
            orderType: OrderType.ASC_OR_SMALLER,
            sortType: null,
            uriType: UriType.EXTERNAL),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                "No songs found on this device !!",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0,
                  color: Colors.red,
                ),
              ),
            );
          } else {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    clipBehavior: Clip.antiAlias,
                    margin: const EdgeInsets.symmetric(
                      vertical: 6.0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Obx(
                      () => ListTile(
                        title: Text(snapshot.data![index].displayNameWOExt,
                            style:
                                textStyle(size: 15.0, weight: FontWeight.w600)),
                        subtitle: Text(snapshot.data![index].artist,
                            style:
                                textStyle(size: 12.0, weight: FontWeight.w400)),
                        leading: QueryArtworkWidget(
                          id: snapshot.data![index].id,
                          type: ArtworkType.AUDIO,
                          nullArtworkWidget: const Icon(
                            Icons.queue_music_rounded,
                            size: 48,
                          ),
                        ),
                        trailing:
                            !controller.favSongs.contains(snapshot.data![index])
                                ? const Icon(
                                    Icons.favorite_outline,
                                    color: white,
                                    size: 26.0,
                                  )
                                : const Icon(
                                    Icons.favorite_rounded,
                                    color: Colors.red,
                                    size: 26.0,
                                  ),
                        onTap: () {
                          controller.playIndex.value == index
                              ? controller.pausePlayer()
                              : playAndPauseScreen(snapshot, controller, index);
                        },
                        onLongPress: () {
                          showBottomSheet(
                            context: context,
                            builder: (BuildContext ctx) {
                              return Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Container(
                                  height: 120,
                                  color: bgDarkClr,
                                  child: Column(
                                    children: [
                                      ListTile(
                                        leading: const Icon(
                                          Icons.add_to_photos_outlined,
                                          color: white,
                                        ),
                                        title: const Text(
                                          'Add to playlist',
                                          style: TextStyle(color: white),
                                        ),
                                        onTap: () {
                                          Get.back();
                                        },
                                      ),
                                      ListTile(
                                        leading: controller.favSongs
                                                .contains(snapshot.data![index])
                                            ? const Icon(
                                                Icons.favorite_rounded,
                                                color: Colors.red,
                                              )
                                            : const Icon(
                                                Icons.favorite_outline,
                                                color: white,
                                              ),
                                        title: controller.favSongs
                                                .contains(snapshot.data![index])
                                            ? const Text(
                                                'Remove from favourites',
                                                style: TextStyle(color: white),
                                              )
                                            : const Text(
                                                'Add to favourites',
                                                style: TextStyle(color: white),
                                              ),
                                        onTap: () {
                                          Get.back();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }

  playAndPauseScreen(snapshot, controller, index) {
    Get.to(
      () => PlayerScreen(
        data: snapshot.data!,
      ),
      transition: Transition.fadeIn,
    );
    controller.playAudio(snapshot.data![index].uri, index);
  }
}
