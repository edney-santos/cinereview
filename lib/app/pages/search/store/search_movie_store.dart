import 'package:cinereview/app/data/http/exceptions.dart';
import 'package:cinereview/app/data/models/movie_model.dart';
import 'package:cinereview/app/data/repositories/movies_repository.dart';
import 'package:flutter/material.dart';

class SearchMovieStore {
  final IMoviesRepository repository;

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  final ValueNotifier<List<MovieModel>> foundMovies =
      ValueNotifier<List<MovieModel>>([]);

  final ValueNotifier<String> error = ValueNotifier<String>('');

  SearchMovieStore({required this.repository});

  Future searchMovies(String query) async {
    isLoading.value = true;
    try {
      final result = await repository.searchMovies(query);
      foundMovies.value = result;
    } on NotFoundException catch (e) {
      error.value = e.message;
    }
    isLoading.value = false;
  }
}
