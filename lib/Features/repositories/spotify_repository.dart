import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:sinov8_tech_assignment/Features/models/spotify/artist_model.dart';

import '../models/users/user_model.dart';

class SpotifyRepository {
  /*  Future<String> fetchAccessToken() async {
    const client_id = '1d5fc06921954b3d850eeab210c539dd';
    const client_secret = 'c97987886640424f892f4d660ab66de7';

    final authOptions = {
      'url': 'https://accounts.spotify.com/api/token',
      'headers': {
        'Authorization':
            'Basic ${base64.encode(utf8.encode('$client_id:$client_secret'))}',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      'data': {'grant_type': 'client_credentials'},
    };

    try {
      final dio = Dio();
      final url = authOptions['url'] as String;
      final headers = authOptions['headers'] as Map<String, dynamic>;
      final data = authOptions['data'] as Map<String, dynamic>;

      final formData = Uri(queryParameters: data).query;

      final response = await dio.post(
        url,
        options: Options(headers: headers),
        data: formData,
      );
      if (response.statusCode == 200) {
        final body = response.data;
        final token = body['access_token'] as String;
        // Create a UserModel instance
        final userModel = UserModel(
            uid: '',
            email: '', // Set the email value if applicable
            username: '', // Set the username value if applicable
            isAnonymous: true,
            spotifyHeadertoken: token);

        // Store the UserModel instance in Hive
        final box = await Hive.openBox('userBox');
        await box.put('user', userModel);
        await box.close();
        return token;
      } else {
        throw Exception('Failed to fetch access token');
      }
    } catch (e) {
      throw Exception('Failed to fetch access token: $e');
    }
  } */
  Future<String> fetchAccessToken(String genre) async {
    const client_id = '1d5fc06921954b3d850eeab210c539dd';
    const client_secret = 'c97987886640424f892f4d660ab66de7';

    final authOptions = {
      'url': 'https://accounts.spotify.com/api/token',
      'headers': {
        'Authorization':
            'Basic ${base64.encode(utf8.encode('$client_id:$client_secret'))}',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      'data': {'grant_type': 'client_credentials'},
    };

    try {
      final dio = Dio();
      final url = authOptions['url'] as String;
      final headers = authOptions['headers'] as Map<String, dynamic>;
      final data = authOptions['data'] as Map<String, dynamic>;

      final formData = Uri(queryParameters: data).query;

      final response = await dio.post(
        url,
        options: Options(headers: headers),
        data: formData,
      );
      if (response.statusCode == 200) {
        final body = response.data;
        final token = body['access_token'] as String;
        // Create a UserModel instance
        final userModel = UserModel(
            uid: '',
            email: '', // Set the email value if applicable
            username: '', // Set the username value if applicable
            isAnonymous: true,
            spotifyHeadertoken: token);

        // Store the UserModel instance in Hive
        final box = await Hive.openBox('userBox');
        await box.put('user', userModel);
        await box.close();

        // Call getArtistInfoByGenre with the retrieved access token
        await getArtistInfoByGenre(genre, token);

        return token;
      } else {
        throw Exception('Failed to fetch access token');
      }
    } catch (e) {
      throw Exception('Failed to fetch access token: $e');
    }
  }

  Future<void> getArtistInfoByGenre(String genre, String accessToken) async {
    const String baseUrl = 'https://api.spotify.com/v1/search';
    final Map<String, String> headers = {
      'Authorization': 'Bearer $accessToken',
    };
    final Map<String, dynamic> queryParams = {
      'q': 'genre:"$genre"',
      'type': 'artist',
      'limit': '100', // Adjust the limit as per your requirements
    };

    final Dio dio = Dio();
    dio.options.headers = headers;

    try {
      final Response response =
          await dio.get(baseUrl, queryParameters: queryParams);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data as Map<String, dynamic>;
        final List<dynamic> artists = data['artists']['items'];

        final List<ArtistModel> artistList = artists.map((artist) {
          final String id = artist['id'] as String;
          final String name = artist['name'] as String;
          final int popularity = artist['popularity'];
          final List<dynamic> genres = artist['genres'] as List<dynamic>;
          final List<String> genreList =
              genres.map((genre) => genre.toString()).toList();

          final List<dynamic> images = artist['images'] as List<dynamic>;
          final List<String> imageList =
              images.map((img) => img.toString()).toList();

          return ArtistModel(
            id: id,
            name: name,
            popularity: popularity,
            images: imageList,
            genres: genreList,
          );
        }).toList();

        final box = await Hive.openBox('artistBox');
        await box.put('artist', artistList);
        await box.close();
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}
