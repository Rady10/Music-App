import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:music/core/providers/current_user_notifier.dart';
import 'package:music/core/utils.dart';
import 'package:music/features/home/model/fav_song_model.dart';
import 'package:music/features/home/model/genre_model.dart';
import 'package:music/features/home/model/song_model.dart';
import 'package:music/features/home/repositories/home_local_repository.dart';
import 'package:music/features/home/repositories/home_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'home_viewmodel.g.dart';


@riverpod
Future<List<SongModel>> getAllSongs(GetAllSongsRef ref) async{
  final token = ref.watch(currentUserNotifierProvider.select((user)=>user!.token));
  final res = await ref.watch(homeRepositoryProvider).getAllSongs(token: token);
  return switch(res){
    Left(value: final l) => throw l.message,
    Right(value: final r) => r
  };
}

@riverpod
Future<List<SongModel>> getGenreSongs(GetGenreSongsRef ref, String genreName) async{
  final res = await ref.watch(homeRepositoryProvider).getGenreSongs(name: genreName);
  return switch(res){
    Left(value: final l) => throw l.message,
    Right(value: final r) => r
  };
}


@riverpod
Future<List<GenreModel>> getAllGenres(GetAllGenresRef ref) async{
  final res = await ref.watch(homeRepositoryProvider).getAllGeners();
  return switch(res){
    Left(value: final l) => throw l.message,
    Right(value: final r) => r
  };
}

@riverpod
Future<List<SongModel>> getFavoriteSongs(GetFavoriteSongsRef ref) async{
  final token = ref.watch(currentUserNotifierProvider)!.token;
  final res = await ref.watch(homeRepositoryProvider).getFavoriteSongs(token: token);
  return switch(res){
    Left(value: final l) => throw l.message,
    Right(value: final r) => r
  };
}

@riverpod
class HomeViewmodel extends _$HomeViewmodel{
  late HomeRepository _homeRepository;
  late HomeLocalRepository _homeLocalRepository;
  @override
  AsyncValue? build(){
    _homeRepository = ref.watch(homeRepositoryProvider);
    _homeLocalRepository = ref.watch(homeLocalRepositoryProvider);
    return null;
  }

  Future <void> uploadSong({
    required File selectedAudio,
    required File selectedThumbnail,
    required String songName,
    required String artist,  
    required String genre,  
    required Color color,  
  }) async {
    state = const AsyncValue.loading();
    final res = await _homeRepository.uploadSong(
      selectedAudio,
      selectedThumbnail, 
      songName, 
      artist, 
      genre, 
      rgbToHex(color), 
      ref.read(currentUserNotifierProvider)!.token
    );
    final val = switch(res){
      Left(value: final l) => state = AsyncValue.error(l.message, StackTrace.current),
      Right(value: final r) => state = AsyncValue.data(r)
    };
    print(val);
  }

  Future <void> uploadGenre({
    required File selectedImage,
    required String genreName,  
    required Color color,  
  }) async {
    state = const AsyncValue.loading();
    final res = await _homeRepository.uploadGenre(
      selectedImage, 
      genreName,  
      rgbToHex(color), 
    );
    final val = switch(res){
      Left(value: final l) => state = AsyncValue.error(l.message, StackTrace.current),
      Right(value: final r) => state = AsyncValue.data(r)
    };
    print(val);
  }

  Future <void> favoriteSong({
    required String songId  
  }) async {
    state = const AsyncValue.loading();
    final res = await _homeRepository.favoriteSong(
     songId: songId,
     token: ref.read(currentUserNotifierProvider)!.token
    );
    final val = switch(res){
      Left(value: final l) => state = AsyncValue.error(l.message, StackTrace.current),
      Right(value: final r) => state = _favSongSuccess(r, songId)
    };
    print(val);
  }

  List<SongModel> getRecentlyPlayedSongs(){
    return _homeLocalRepository.loadSongs(); 
  }

  AsyncValue _favSongSuccess(bool isFavorited, String songId){
    final userNotifier = ref.read(currentUserNotifierProvider.notifier);
    if(isFavorited){
      userNotifier.addUser(
        ref.read(currentUserNotifierProvider)!.copyWith(
          favorites: [
            ... ref.read(currentUserNotifierProvider)!.favorites,
            FavSongModel(id: '', song_id: songId, user_id: '')
          ],
        ),
      );
    }
    else{
      userNotifier.addUser(
        ref.read(currentUserNotifierProvider)!.copyWith(
          favorites: ref.read(currentUserNotifierProvider)!.favorites.where((fav)=> fav.song_id != songId).toList()
        ),
      );
    }
    ref.invalidate(getFavoriteSongsProvider);
    return state = AsyncValue.data(isFavorited);
  }  

}
