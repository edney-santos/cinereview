import 'package:cinereview/app/data/http/exceptions.dart';
import 'package:cinereview/app/data/models/movie_model.dart';
import 'package:cinereview/app/data/repositories/movies_repository.dart';
import 'package:flutter/foundation.dart';

class MoviesCategoryStore {
  final IMoviesRepository repository;

  // Variável reativa para o loading
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  // Variável reativa para o state
  final ValueNotifier<List<MovieModel>> moviesByGender =
      ValueNotifier<List<MovieModel>>([]);

  // Variável reativa para o erro
  final ValueNotifier<String> error = ValueNotifier<String>('');

  MoviesCategoryStore({required this.repository});

  Future getByGender(String genderId) async {
    isLoading.value = true;

    try {
      final result = await repository.getMoviesByGender(genderId);
      moviesByGender.value = result;
    } on NotFoundException catch (e) {
      error.value = e.message;
    } catch (e) {
      error.value = e.toString();
    }

    isLoading.value = false;
  }
}
