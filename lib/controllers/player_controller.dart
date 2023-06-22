import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class PlayerController extends GetxController {
  final audioQuery = OnAudioQuery();
  final audioPlayer = AudioPlayer();

  var playIndex = 0.obs;
  var isPLaying = false.obs;

  var duration = ''.obs;
  var position = ''.obs;

  var max = 0.0.obs;
  var value = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    checkPermissions();
  }

  updatePosition() {
    audioPlayer.durationStream.listen((e) {
      duration.value = e.toString().split(".")[0];
      max.value = e!.inSeconds.toDouble();
    });
    audioPlayer.positionStream.listen((e) {
      position.value = e.toString().split(".")[0];
      value.value = e.inSeconds.toDouble();
    });
  }

  updateDurationToSeconds(seconds) {
    var duration = Duration(seconds: seconds);
    audioPlayer.seek(duration);
  }

  playAudio(String uri, index) {
    playIndex.value = index;
    try {
      audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri)));
      audioPlayer.play();
      isPLaying(true);
      updatePosition();
    } on Exception catch (e) {
      printError(info: e.toString());
    }
  }

  pausePlayer() {
    playIndex.value = 0;
    isPLaying(false);
    audioPlayer.pause();
  }

  checkPermissions() async {
    var perm = await Permission.storage.request();
    if (perm.isDenied) checkPermissions();
  }
}
