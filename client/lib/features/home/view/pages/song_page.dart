import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music/core/providers/current_song_notifier.dart';
import 'package:music/core/theme/app_pallete.dart';
import 'package:music/core/utils.dart';
import 'package:music/core/widgets/loader.dart';
import 'package:music/features/home/viewmodel/home_viewmodel.dart';

class SongPage extends ConsumerWidget {
  const SongPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentPlayedSongs = ref.read(homeViewmodelProvider.notifier).getRecentlyPlayedSongs();
    final currentSong = ref.watch(currentSongNotifierProvider);
    return AnimatedContainer(
      padding: const EdgeInsets.only(top: 20),
      duration: const Duration(milliseconds: 500),
      decoration: currentSong == null 
      ? null 
      : BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            hexToColor(currentSong.color),
            Pallete.backgroundColor,
          ],
          stops: const [0.0, 0.2]
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 20, left: 10),
            child: Text(
              'Played Recently',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w700
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 36),
            child: SizedBox(
              height: 230,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent:200,
                  childAspectRatio: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: recentPlayedSongs.length,
                itemBuilder: (context,index){
                  final currentSong = recentPlayedSongs[index];
                  return GestureDetector(
                    onTap: (){
                      ref.read(currentSongNotifierProvider.notifier).updateSong(currentSong);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Pallete.cardColor,
                        borderRadius: BorderRadius.circular(6) 
                      ),
                      padding: const EdgeInsets.only(right: 20),
                      child: Row(
                        children: [
                            Container(
                            width: 56,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(4), 
                                bottomLeft: Radius.circular(4), 
                              ),
                              image: DecorationImage(
                                image: NetworkImage(
                                  currentSong.thumbnail_url,     
                                ),
                                fit: BoxFit.fill,
                              )
                            ),
                          ),
                          const SizedBox(width: 8,),
                          Flexible(
                            child: Text(
                              currentSong.name,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                              maxLines: 1,
                            ),
                          )
                        ],
                      ),
                    ),
                  );  
                }
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Latest Songs',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w700
              ),
            ),
          ),
          ref.watch(getAllSongsProvider).when(
            data: (songs){
              return SizedBox(
                height: 260,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: songs.length,
                  itemBuilder: (context, index){
                    final song = songs[index];
                    return GestureDetector(
                      onTap: (){
                        ref.read(currentSongNotifierProvider.notifier).updateSong(song);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 180,
                              height: 180,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(song.thumbnail_url),
                                  fit: BoxFit.cover
                                ),
                                borderRadius: BorderRadius.circular(8)
                              ),
                            ),
                            const SizedBox(height: 5,),
                            SizedBox(
                              width: 180,
                              child: Text(
                                song.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  overflow: TextOverflow.ellipsis
                                ),
                                maxLines: 1,
                              ),
                            ),
                            SizedBox(
                              width: 180,
                              child: Text(
                                song.artist,
                                style: const TextStyle(
                                  color: Pallete.subtitleText,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  overflow: TextOverflow.ellipsis
                                ),
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                ),
              );
            }, 
            error: (error , st){
              return Center(
                child: Text(
                  error.toString()
                ),
              );
            }, 
            loading: () => const Loader()
          )
        ],
      ),
    );
  }
}