import 'dart:convert';

import 'package:cinereview/app/data/http/exceptions.dart';
import 'package:cinereview/app/data/http/http_client.dart';
import 'package:cinereview/app/data/models/movie_model.dart';

abstract class IMoviesRepository {
  Future<List<MovieModel>> getTrendMovies();
}

class MoviesRepository implements IMoviesRepository {
  final IHttpClient client;

  MoviesRepository({required this.client});

  @override
  Future<List<MovieModel>> getTrendMovies() async {
    final response = await client.get(
      url: ApiUrls.trendMovies,
    );

    if (response.statusCode == 200) {
      final List<MovieModel> movies = [];
      final body = jsonDecode(response.body);

      body['results'].map((item) {
        final MovieModel movie = MovieModel.fromMap(item);
        movies.add(movie);
      }).toList();

      return movies;
    } else if (response.statusCode == 404) {
      throw NotFoundException('A url informada não é válida.');
    } else {
      throw Exception('Não foi possível carregar os filmes.');
    }
  }
}
