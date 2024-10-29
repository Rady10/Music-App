import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music/core/providers/current_song_notifier.dart';
import 'package:music/core/theme/app_pallete.dart';
import 'package:music/core/utils.dart';
import 'package:music/core/widgets/loader.dart';
import 'package:music/features/home/viewmodel/home_viewmodel.dart';

class GenrePage extends ConsumerWidget {
  final String genreName;
  final String genreColor; 
  final String genreUrl;

  const GenrePage({
    super.key,
    required this.genreName,
    required this.genreColor,
    required this.genreUrl,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          genreName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: hexToColor(genreColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text(
              'Discover new music',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(height: 10,),
            ref.watch(getGenreSongsProvider(genreName)).when(
              data: (songs){
                return SizedBox(
                  height: 600,
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 250,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 20,
                        childAspectRatio: 0.8
                    ),
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
                                    fit: BoxFit.fill
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
            ),
          ],
        ),
      )
    );
  }
}


