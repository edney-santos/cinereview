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

  // Variável reativa para o erro
  ValueNotifier<double> currentValue = ValueNotifier<double>(0.0);

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

  Future<void> deleteReview(String reviewId, int index) async {
    try {
      isLoading.value = true;
      await repository.deleteReview(reviewId, index);
      isLoading.value = false;
    } catch (e) {
      error.value = e.toString();
    }
  }

  Future<void> editReview(
    String reviewId,
    int movieID,
    String movieTitle,
    String userName,
    double rating,
    String review,
    int index,
  ) async {
    try {
      isLoading.value = true;
      await repository.editReview(
        reviewId,
        movieID,
        movieTitle,
        userName,
        rating,
        review,
        index,
      );
      isLoading.value = false;
    } catch (e) {
      error.value = e.toString();
    }
  }
}
