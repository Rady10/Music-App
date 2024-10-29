import 'dart:convert';
import 'dart:io';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:music/core/constants/server_constant.dart';
import 'package:music/core/failure/failure.dart';
import 'package:music/features/home/model/genre_model.dart';
import 'package:music/features/home/model/song_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'home_repository.g.dart';

@riverpod
HomeRepository homeRepository(HomeRepositoryRef ref){
  return HomeRepository();
}

class HomeRepository{
  Future <Either<AppFailure, String>> uploadSong (
      File selectedAudio,
      File selectedThumbnail,
      String songName,
      String artist,  
      String genre,
      String color,
      String token
    ) async{
    try{

      final request = http.MultipartRequest(
        'POST', 
        Uri.parse('${ServerConstant.serverURL}/song/upload'),
      );
      request..files.addAll([
        await http.MultipartFile.fromPath(
          'song', 
          selectedAudio.path 
        ),
        await http.MultipartFile.fromPath(
          'thumbnail', 
          selectedThumbnail.path 
        ),
      ])..fields.addAll({
        'artist' : artist,
        'name' : songName,
        'genre' : genre, 
        'color' : color,
      })..headers.addAll({
        'x-auth-token' : token
      });
      
      final res = await request.send();
      if(res.statusCode != 201){
        return Left(AppFailure(await res.stream.bytesToString()));
      }
      return Right(await res.stream.bytesToString());
      

    }catch(e){
      return Left(AppFailure(e.toString()));
    }
  
  }

  Future <Either<AppFailure, List<SongModel>>> getAllSongs({
    required String token
  }) async {
    try{
      final response =  await http.get(
        Uri.parse('${ServerConstant.serverURL}/song/list'),
        headers: {
          'Content-Type': 'application/json',
          'x-auth-token' : token
        }
      );
      var resBody = jsonDecode(response.body);

      if(response.statusCode != 200){

        resBody = resBody as Map<String, dynamic>;
        return Left(AppFailure(resBody['detail']));
      }

      resBody = resBody as List;

      List<SongModel> songs = [];

      for(final map in resBody){
        songs.add(SongModel.fromMap(map));
      }

      return Right(songs);

    }catch(e){
      return Left(AppFailure(e.toString()));
    }
  }

  Future <Either<AppFailure, List<GenreModel>>> getAllGeners() async {
    try{
      final response =  await http.get(
        Uri.parse('${ServerConstant.serverURL}/genre/list'),
        headers: {
          'Content-Type': 'application/json',
        }
      );
      var resBody = jsonDecode(response.body);

      if(response.statusCode != 200){
        resBody = resBody as Map<String, dynamic>;
        return Left(AppFailure(resBody['detail']));
      }

      resBody = resBody as List;

      List<GenreModel> genres = [];

      for(final map in resBody){
        genres.add(GenreModel.fromMap(map));
      }

      return Right(genres);

    }catch(e){
      return Left(AppFailure(e.toString()));
    }
  }

  Future <Either<AppFailure, bool>> favoriteSong({
    required String token,
    required String songId
  }) async {
    try{
      final response =  await http.post(
        Uri.parse('${ServerConstant.serverURL}/song/favorite'),
        headers: {
          'Content-Type': 'application/json',
          'x-auth-token' : token
        },
        body: jsonEncode(
          {
            "song_id" : songId
          }
        )
      );
      var resBody = jsonDecode(response.body);

      if(response.statusCode != 200){

        resBody = resBody as Map<String, dynamic>;
        return Left(AppFailure(resBody['detail']));
      }

      return Right(resBody['message']);

    }catch(e){
      return Left(AppFailure(e.toString()));
    }
  }

  Future <Either<AppFailure, List<SongModel>>> getFavoriteSongs({
    required String token,
  }) async {
    try{
      final response =  await http.get(
        Uri.parse('${ServerConstant.serverURL}/song/list/favorites'),
        headers: {
          'Content-Type': 'application/json',
          'x-auth-token' : token
        }
      );
      var resBody = jsonDecode(response.body);

      if(response.statusCode != 200){

        resBody = resBody as Map<String, dynamic>;
        return Left(AppFailure(resBody['detail']));
      }

      resBody = resBody as List;

      List<SongModel> songs = [];

      for(final map in resBody){
        songs.add(SongModel.fromMap(map['song']));
      }

      return Right(songs);

    }catch(e){
      return Left(AppFailure(e.toString()));
    }
  }


Future<Either<AppFailure, String>> uploadGenre(
    File selectedImage,
    String genreName,  
    String color,
) async {
  try {
    final request = http.MultipartRequest(
      'POST', 
      Uri.parse('${ServerConstant.serverURL}/genre/upload'),
    );

    request.files.add(await http.MultipartFile.fromPath('image', selectedImage.path));
    request.fields['name'] = genreName;
    request.fields['color'] = color;

    final res = await request.send();

    // Check the response status code
    if (res.statusCode != 201) {
      final responseString = await res.stream.bytesToString();
      return Left(AppFailure(responseString));
    }

    // Return successful response
    final responseString = await res.stream.bytesToString();
    return Right(responseString);

  } catch (e) {
    return Left(AppFailure(e.toString()));
  }
}

  Future <Either<AppFailure, List<SongModel>>> getGenreSongs({
    required String name,
  }) async {
    try{
      final response =  await http.get(
        Uri.parse('${ServerConstant.serverURL}/genre/$name'),
        headers: {
          'Content-Type': 'application/json',
        }
      );
      var resBody = jsonDecode(response.body);

      if(response.statusCode != 200){

        resBody = resBody as Map<String, dynamic>;
        return Left(AppFailure(resBody['detail']));
      }

      resBody = resBody as List;

      List<SongModel> songs = [];

      for(final map in resBody){
        songs.add(SongModel.fromMap(map));
      }

      return Right(songs);

    }catch(e){
      return Left(AppFailure(e.toString()));
    }
  }

}