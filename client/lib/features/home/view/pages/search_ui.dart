import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music/core/providers/current_song_notifier.dart';
import 'package:music/core/theme/app_pallete.dart';
import 'package:music/core/widgets/loader.dart';
import 'package:music/features/home/model/song_model.dart';
import 'package:music/features/home/viewmodel/home_viewmodel.dart';

class SearchUi extends ConsumerStatefulWidget {
  const SearchUi({super.key});

  @override
  ConsumerState<SearchUi> createState() => _SearchUiState();
}

class _SearchUiState extends ConsumerState<SearchUi> {
  final TextEditingController searchController = TextEditingController();
  List<SongModel> filteredSongs = [];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  static _border(Color color) => OutlineInputBorder(
        borderSide: BorderSide(color: color, width: 3),
        borderRadius: BorderRadius.circular(10),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                color: Pallete.greyColor.withOpacity(0.333),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 30,
                    ),
                  ),
                  Flexible(
                    child: TextFormField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'What do you want to listen to?',
                        contentPadding: const EdgeInsets.all(0),
                        focusedBorder: _border(Pallete.transparentColor),
                        enabledBorder: _border(Pallete.transparentColor),
                      ),
                      onChanged: (val) {
                        setState(() {
                          // Filter the songs as the user types
                          filter(val);
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            ref.watch(getAllSongsProvider).when(
              data: (songs) {
                // Filter songs only when there is text in the search field
                return Expanded(
                  child: ListView.builder(
                    itemCount: filteredSongs.length,
                    itemBuilder: (context, index) {
                      final song = filteredSongs[index];
                      return ListTile(
                        onTap: () {
                          ref
                              .read(currentSongNotifierProvider.notifier)
                              .updateSong(song);
                        },
                        leading: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(song.thumbnail_url),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        title: Text(
                          song.name,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        subtitle: Text(
                          song.artist,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
              error: (error, st) {
                return Center(
                  child: Text(error.toString()),
                );
              },
              loading: () => const Loader(),
            ),
          ],
        ),
      ),
    );
  }

  void filter(String enteredVal) {
    // Get the data from the provider
    final songs = ref.read(getAllSongsProvider).value ?? [];

    // Perform filtering based on the entered value
    if (enteredVal.isEmpty) {
      filteredSongs = []; // Keep filteredSongs empty when there's no input
    } else {
      filteredSongs = songs
          .where((song) =>
              song.name.toLowerCase().contains(enteredVal.toLowerCase()) ||
              song.artist.toLowerCase().contains(enteredVal.toLowerCase()))
          .toList();
    }
  }
}
