import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music/core/providers/current_song_notifier.dart';
import 'package:music/core/providers/current_user_notifier.dart';
import 'package:music/core/theme/app_pallete.dart';
import 'package:music/core/utils.dart';
import 'package:music/features/home/view/widgets/music_player.dart';
import 'package:music/features/home/viewmodel/home_viewmodel.dart';

class MusicSlap extends ConsumerWidget {
  const MusicSlap({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSong = ref.watch(currentSongNotifierProvider);
    final songNotifier = ref.read(currentSongNotifierProvider.notifier);
    final userFavorites = ref.watch(currentUserNotifierProvider.select((data)=> data!.favorites));
    if(currentSong == null){
      return const SizedBox();
    }

    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const MusicPlayer()
          ),
        );
      },
      child: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            padding: const EdgeInsets.all(9.0),
            decoration: BoxDecoration(
              color: hexToColor(currentSong.color),
              borderRadius: BorderRadius.circular(5)
            ),
            width: MediaQuery.of(context).size.width-5,
            height: 66,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        image: DecorationImage(
                          image: NetworkImage(
                            currentSong.thumbnail_url,     
                          ),
                          fit: BoxFit.cover,
                        )
                      ),
                    ),
                    const SizedBox(width: 8,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentSong.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        
                        Text(
                          currentSong.artist,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Pallete.subtitleText
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () async{
                       await ref.read(homeViewmodelProvider.notifier).favoriteSong(songId: currentSong.id);
                      }, 
                      icon: Icon(
                        userFavorites.where((fav) => fav.song_id == currentSong.id).toList().isNotEmpty
                        ? CupertinoIcons.heart_fill
                        : CupertinoIcons.heart,
                        color: Pallete.whiteColor,
                      )
                    ),
                    IconButton(
                      onPressed: songNotifier.playAndPause, 
                      icon: Icon(
                        songNotifier.isPlaying
                        ?  CupertinoIcons.pause_fill
                        :  CupertinoIcons.play_fill,
                        color: Pallete.whiteColor,
                      )
                    ),
                  ],
                )
              ],
            ),
          ),
          StreamBuilder(
            stream: songNotifier.audioPlayer.positionStream,
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting){
                return const SizedBox();
              }
              final position = snapshot.data;
              final duration = songNotifier.audioPlayer.duration;
              double sliderVal = 0.0;
      
              if(position!= null && duration != null){
                sliderVal = position.inMilliseconds / duration.inMilliseconds;
              }  
              return Positioned(
                left: 8,
                bottom: 0,
                child: Container(
                  height: 2,
                  width: sliderVal * (MediaQuery.of(context).size.width - 20),
                  decoration: const BoxDecoration(
                    color: Pallete.whiteColor
                  ),
                )
              );
            }
          ),
          Positioned(
            left: 8,
            bottom: 0,
            child: Container(
              height: 2,
              width: MediaQuery.of(context).size.width - 20,
              decoration: const BoxDecoration(
                color: Pallete.inactiveSeekColor
              ),
            )
          ),
        ],
      ),
    );
  }
}