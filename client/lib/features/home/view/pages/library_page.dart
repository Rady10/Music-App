import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music/core/providers/current_song_notifier.dart';
import 'package:music/core/widgets/loader.dart';
import 'package:music/features/home/view/pages/upload_song_page.dart';
import 'package:music/features/home/viewmodel/home_viewmodel.dart';

class LibraryPage extends ConsumerWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    return ref.watch(getFavoriteSongsProvider).when(
      data: (data){
        return ListView.builder(
          itemCount: data.length + 1,
          itemBuilder: (context, index){
            if(index == data.length){
                return ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const UploadSongPage()));
                },
                leading: const SizedBox(
                  width: 80,
                  height: 80,
                  child: Icon(CupertinoIcons.plus),
                ),
                title: const Text(
                  'Upload new song',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700
                  ),
                ),
              );
            }
            final song = data[index];
            return ListTile(
              onTap: () {
                ref.read(currentSongNotifierProvider.notifier).updateSong(song);
              },
              leading: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(song.thumbnail_url)
                  ),
                  borderRadius: BorderRadius.circular(10)
                ),
              ),
              title: Text(
                song.name,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700
                ),
              ),
              subtitle: Text(
                song.artist,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600
                ),
              ),
            );
          }
        );
      },
      error: (error, st){
        return Center(
          child: Text(error.toString()),
        );
      },
      loading: () => const Loader() 
    );
    
  }
}