import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_playaer/constants/colors.dart';
import 'package:music_playaer/controllers/player_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayerScreen extends StatelessWidget {
  final List<SongModel> data;
  const PlayerScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<PlayerController>();
    return Scaffold(
      backgroundColor: bgDarkClr,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Obx(
              () => Expanded(
                child: Container(
                  alignment: Alignment.center,
                  height: 400,
                  width: 400,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.blue.shade200),
                  child: QueryArtworkWidget(
                    id: data[controller.playIndex.value].id,
                    type: ArtworkType.AUDIO,
                    artworkHeight: double.infinity,
                    artworkWidth: double.infinity,
                    nullArtworkWidget: const Icon(
                      Icons.music_note_rounded,
                      size: 35.0,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 30.0,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16.0),
                  ),
                ),
                child: Obx(
                  () => Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        data[controller.playIndex.value].displayNameWOExt,
                        style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: bgDarkClr,
                        ),
                        overflow: TextOverflow.fade,
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        data[controller.playIndex.value].artist.toString(),
                        style: const TextStyle(
                          fontSize: 20.0,
                          color: bgDarkClr,
                        ),
                        overflow: TextOverflow.fade,
                      ),
                      const Expanded(
                        child: SizedBox(
                          height: 30.0,
                        ),
                      ),
                      Obx(
                        () => Row(
                          children: [
                            Text(
                              controller.position.value,
                              style: const TextStyle(color: bgDarkClr),
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            Expanded(
                              child: Slider(
                                thumbColor: sliderClr,
                                inactiveColor: bgColor,
                                activeColor: sliderClr,
                                min: const Duration(seconds: 0)
                                    .inSeconds
                                    .toDouble(),
                                max: controller.max.value,
                                value: controller.value.value,
                                onChanged: (newValue) {
                                  controller.updateDurationToSeconds(
                                      newValue.toInt());
                                  newValue = newValue;
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              controller.duration.value,
                              style: const TextStyle(color: bgDarkClr),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              controller.playAudio(
                                  data[controller.playIndex.value - 1]
                                      .uri
                                      .toString(),
                                  controller.playIndex.value - 1);
                            },
                            icon: const Icon(Icons.skip_previous_rounded),
                            iconSize: 60,
                          ),
                          Obx(
                            () => CircleAvatar(
                              radius: 30,
                              backgroundColor: bgDarkClr,
                              child: Transform.scale(
                                scale: 2,
                                child: controller.isPLaying.value
                                    ? IconButton(
                                        onPressed: () {
                                          if (controller.isPLaying.value) {
                                            controller.audioPlayer.pause();
                                            controller.isPLaying(false);
                                          } else {
                                            controller.audioPlayer.play();
                                            controller.isPLaying(true);
                                          }
                                        },
                                        icon: const Icon(Icons.pause_rounded),
                                        color: white,
                                      )
                                    : IconButton(
                                        onPressed: () {
                                          if (controller.isPLaying.value) {
                                            controller.audioPlayer.pause();
                                            controller.isPLaying(false);
                                          } else {
                                            controller.audioPlayer.play();
                                            controller.isPLaying(true);
                                          }
                                        },
                                        icon: const Icon(
                                            Icons.play_arrow_rounded),
                                        color: white,
                                      ),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              controller.playAudio(
                                  data[controller.playIndex.value + 1]
                                      .uri
                                      .toString(),
                                  controller.playIndex.value + 1);
                            },
                            icon: const Icon(Icons.skip_next_rounded),
                            iconSize: 60,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
