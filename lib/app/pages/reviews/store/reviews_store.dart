import 'package:cinereview/app/data/models/review_model.dart';
import 'package:cinereview/app/data/repositories/reviews_repository.dart';
import 'package:flutter/material.dart';

class ReviewsStore {
  final ReviewsRepository repository;

  // Variável reativa para o loading
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  // Variável reativa para o state
  final ValueNotifier<List<ReviewModel>> userReviews =
      ValueNotifier<List<ReviewModel>>([]);

  // Variável reativa para o erro
  final ValueNotifier<String> error = ValueNotifier<String>('');

  ReviewsStore(this.repository);

  Future<void> getReviews() async {
    try {
      isLoading.value = true;
      List<ReviewModel> reviews = await repository.getUserReviews();
      userReviews.value = reviews;
      isLoading.value = false;
    } catch (e) {
      error.value = e.toString();
    }
  }
}
