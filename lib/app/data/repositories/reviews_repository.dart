import 'package:cinereview/app/data/database/db_firestore.dart';
import 'package:cinereview/app/data/models/info_model.dart';
import 'package:cinereview/app/data/models/movie_model.dart';
import 'package:cinereview/app/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ReviewsRepository extends ChangeNotifier {
  late FirebaseFirestore db;
  late AuthService auth;

  ReviewsRepository({required this.auth}) {
    _startRepository();
  }

  _startRepository() async {
    await _startFirestore();
  }

  _startFirestore() {
    db = DBFirestore.get();
  }

  Future<void> addReviews(
    MovieModel movie,
    String userName,
    double rating,
    String review,
  ) async {
    final CollectionReference reviewsCollection = db.collection('reviews');

    try {
      await reviewsCollection.add({
        'movieId': movie.id,
        'movieTitle': movie.title,
        'reviewerName': userName,
        'reviewerId': auth.user!.uid,
        'review': review,
        'rating': rating,
        'timestamp': FieldValue.serverTimestamp(),
      });
      print('Review adicionado');
    } catch (e) {
      print('Algo deu errado: $e');
    }
  }
}
