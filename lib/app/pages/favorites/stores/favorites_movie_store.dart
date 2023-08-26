import 'package:cinereview/app/data/http/exceptions.dart';
import 'package:cinereview/app/data/models/movie_model.dart';
import 'package:cinereview/app/data/repositories/movies_repository.dart';
import 'package:cinereview/app/data/repositories/users_repository.dart';
import 'package:flutter/material.dart';

class FavoritesMoviesStore {
  final IMoviesRepository repository;
  final UsersRepository user;

  // Variável reativa para o loading
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  // Variável reativa para o state
  final ValueNotifier<List<MovieModel>> favoriteMovies =
      ValueNotifier<List<MovieModel>>([]);

  // Variável reativa para o erro
  final ValueNotifier<String> error = ValueNotifier<String>('');

  FavoritesMoviesStore({required this.repository, required this.user});

  Future getFavoritesMovies() async {
    try {
      isLoading.value = true;

      List<dynamic> favoriteIds = await user.getFavorites();
      List<Future<MovieModel>> responses = [];

      for (int i = 0; i < favoriteIds.length; i++) {
        responses.add(repository.getById(favoriteIds[i]));
      }

      favoriteMovies.value = await Future.wait(responses);
      isLoading.value = false;

    } on NotFoundException catch (e) {
      error.value = e.message;
    } catch (e) {
      error.value = e.toString();
    }
  }
}
