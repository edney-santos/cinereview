import 'package:cinereview/app/data/http/exceptions.dart';
import 'package:cinereview/app/data/models/movie_model.dart';
import 'package:cinereview/app/data/repositories/movies_repository.dart';
import 'package:flutter/foundation.dart';

class MoviesStore {
  final IMoviesRepository repository;

  // Variável reativa para o loading
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  // Variável reativa para o state
  final ValueNotifier<List<MovieModel>> trendMovies =
      ValueNotifier<List<MovieModel>>([]);

  // Variável reativa para o erro
  final ValueNotifier<String> error = ValueNotifier<String>('');

  MoviesStore({required this.repository});

  Future getTrendMovies() async {
    isLoading.value = true;

    try {
      final result = await repository.getTrendMovies();
      trendMovies.value = result;
    } on NotFoundException catch (e) {
      error.value = e.message;
    } catch (e) {
      error.value = e.toString();
    }

    isLoading.value = false;
  }
}
