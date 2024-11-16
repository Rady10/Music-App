
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music/core/providers/current_song_notifier.dart';
import 'package:music/core/theme/app_pallete.dart';
import 'package:music/core/widgets/loader.dart';
import 'package:music/features/auth/repositories/auth_local_repository.dart';
import 'package:music/features/auth/view/pages/login_page.dart';
import 'package:music/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:music/features/home/view/pages/upload_song_page.dart';
import 'package:music/features/home/viewmodel/home_viewmodel.dart';

class LibraryPage extends ConsumerWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 10),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: (){
                  ref.read(authViewmodelProvider.notifier).logOut();
                },
                child: const CircleAvatar(
                  backgroundColor: Pallete.whiteColor,
                  child: Icon(Icons.person,color: Colors.black,),
                ),
              ),
              const SizedBox(width: 30,),
              const Text(
                'Your Library',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
          Container(
            height: MediaQuery.of(context).size.height-150,
            child: ref.watch(getFavoriteSongsProvider).when(
              data: (data){
                return ListView.builder(
                  itemCount: data.length + 1,
                  itemBuilder: (context, index){
                    if(index == data.length){
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const UploadSongPage()));
                              },
                              child: Row(
                              children: [
                                Container(
                                  height: 70,
                                  width: 70,
                                  child: const Icon(Icons.add),
                                ),
                                const SizedBox(width: 20,),
                                const Text(
                                  'Upload a Song',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700
                                  ),
                                ),
                              ],  
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              ref.read(authLocalRepositoryProvider).clear();
                              ref.read(currentSongNotifierProvider.notifier).playAndPause();
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const LoginPage()));
                            },
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              child: const Row(
                                children: [
                                  Icon(
                                    Icons.exit_to_app,
                                    size: 30,
                                  ),
                                  SizedBox(width: 30,),
                                  Text(
                                    'Log out',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                          ],
                        );
                    }
                    final song = data[index];
                    return GestureDetector(
                      onTap: (){
                        ref.watch(currentSongNotifierProvider.notifier).updateSong(song);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    song.thumbnail_url
                                  ),
                                  fit: BoxFit.fill
                                ),
                              ),
                            ),
                            const SizedBox(width: 20,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  song.name,
                                  style: const TextStyle(
                                    color: Pallete.whiteColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  song.artist,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: Pallete.subtitleText
                                  ),
                                ),
                              ],
                            )
                          ],
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
            ),
          ),  
        ],
      ),
    );
    
  }
}