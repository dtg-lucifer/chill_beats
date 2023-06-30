import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:localstorage/localstorage.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class PlayerController extends GetxController {
  final LocalStorage storage = LocalStorage('playlists.json');
  late bool? _storageState;
  final audioQuery = OnAudioQuery();
  final audioPlayer = AudioPlayer();
  final List<SongModel> favSongs = [];

  var playIndex = 0.obs;
  var isPLaying = false.obs;

  var duration = ''.obs;
  var position = ''.obs;

  var max = 0.0.obs;
  var value = 0.0.obs;

  late ConcatenatingAudioSource currentPlaylist;

  @override
  void onInit() async {
    super.onInit();
    checkPermissions();
    _storageState = await storage.ready;
    getPlaylist();
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.dispose();
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

  getPlaylist() async {
    if (_storageState!) {
      var playLists = storage.getItem('playlists');
      return playLists;
    }
  }

  createPlayList(String name) async {
    var playList = {"name": name, "songs": []};
    if (_storageState!) {
      await storage.setItem(name, playList);
      return playList;
    }
  }

  addSongsToPlayList(String plName, SongModel song) {
    if (_storageState!) {
      var playList = storage.getItem(plName);
      playList.songs!.add(song);
      storage.setItem(plName, playList);
    }
  }

  removeSongsFromPlaylist(String plName, SongModel song) {
    if (_storageState!) {
      var playList = storage.getItem(plName);
      playList.songs!.remove(song);
      storage.setItem(plName, playList);
    }
  }

  playSongsFromPlayList(String plName) async {
    if (_storageState!) {
      var playList = storage.getItem(plName);
      var songs = playList.songs;
      currentPlaylist = ConcatenatingAudioSource(children: []);
      songs!.forEach((song) {
        currentPlaylist.add(AudioSource.uri(Uri.parse(song.data)));
      });
      try {
        audioPlayer.setAudioSource(currentPlaylist);
        audioPlayer.play();
        isPLaying(true);
        updatePosition();
      } on Exception catch (e) {
        printError(info: e.toString());
      }
      audioPlayer.currentIndexStream.listen((index) {
        playIndex.value = index!;
      });
    }
  }
}
