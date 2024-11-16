import 'package:music/features/home/model/song_model.dart';
import 'package:music/features/home/repositories/home_local_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:just_audio/just_audio.dart';
part 'current_song_notifier.g.dart';

@riverpod
class CurrentSongNotifier extends _$CurrentSongNotifier{

  AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  bool isRepeating = false;
  late HomeLocalRepository _homeLocalRepository;
  @override
  SongModel? build(){
    _homeLocalRepository = ref.watch(homeLocalRepositoryProvider);
    return null;
  }


  void updateSong(SongModel song) async{
    final audioSource = AudioSource.uri(
      Uri.parse(song.song_url),
    );
    await audioPlayer.setAudioSource(audioSource);
    
    audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        if (isRepeating) {
          audioPlayer.seek(Duration.zero); // Restart song if repeating
        } else {
          audioPlayer.pause();
          isPlaying = false;
        }
        this.state = this.state?.copyWith(color: this.state?.color);
      }
    });
    
    _homeLocalRepository.uploadLocalSong(song);
    audioPlayer.play();
    isPlaying = true;
    state = song;
  }

  void playAndPause(){
    if(isPlaying){
      audioPlayer.pause();
    } else {
      audioPlayer.play();
    }
    isPlaying = !isPlaying;
    state = state?.copyWith(color: state?.color);
  }

  void seek(double val){
    audioPlayer.seek(
      Duration(
        milliseconds: (val * audioPlayer.duration!.inMilliseconds).toInt()
      )
    );
  }

  void toggleRepeat() {
    isRepeating = !isRepeating; 
    state = state?.copyWith(color: state?.color);
  }

  void terminate(){
    audioPlayer.dispose();
  }

}