import 'package:cinereview/app/data/database/db_firestore.dart';
import 'package:cinereview/app/data/models/movie_model.dart';
import 'package:cinereview/app/data/models/review_model.dart';
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
        'date': DateTime.now().toString(),
      });
    } catch (e) {
      throw Exception('Algo deu errado: $e');
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
    final CollectionReference reviewsCollection = db.collection('reviews');

    try {
      QuerySnapshot snapshot = await reviewsCollection
          .where('reviewerId', isEqualTo: auth.user!.uid)
          .get();

      // Verifique se o documento existe antes de tentar editá-lo
      if (snapshot.docs.isNotEmpty) {
        final DocumentReference reviewDoc =
            reviewsCollection.doc(snapshot.docs[index].id);

        await reviewDoc.update({
          'movieId': movieID,
          'movieTitle': movieTitle,
          'reviewerName': userName,
          'reviewerId': auth.user!.uid,
          'review': review,
          'rating': rating,
          'date': DateTime.now().toString(),
        });
      } else {
        throw Exception('Revisão não encontrada com o ID: $reviewId');
      }
    } catch (e) {
      throw Exception('Algo deu errado ao editar a revisão: $e');
    }
  }

  Future<void> deleteReview(String reviewId, int index) async {
    final CollectionReference reviewsCollection = db.collection('reviews');

    try {
      QuerySnapshot snapshot = await reviewsCollection
          .where('reviewerId', isEqualTo: auth.user!.uid)
          .get();

      if (snapshot.docs.isNotEmpty) {
        await reviewsCollection.doc(snapshot.docs[index].id).delete();
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<ReviewModel>> getMovieReviews(int movieId) async {
    final CollectionReference reviewsCollection = db.collection('reviews');

    List<ReviewModel> reviews = [];

    try {
      QuerySnapshot snapshot =
          await reviewsCollection.where('movieId', isEqualTo: movieId).get();

      if (snapshot.docs.isEmpty) {
        return reviews;
      }

      for (DocumentSnapshot doc in snapshot.docs) {
        Map<String, dynamic> dataMap = doc.data() as Map<String, dynamic>;
        reviews.add(ReviewModel.fromMap(dataMap));
      }

      return reviews;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<ReviewModel>> getUserReviews() async {
    final CollectionReference reviewsCollection = db.collection('reviews');

    List<ReviewModel> reviews = [];

    try {
      QuerySnapshot snapshot = await reviewsCollection
          .where('reviewerId', isEqualTo: auth.user!.uid)
          .get();

      if (snapshot.docs.isEmpty) {
        return reviews;
      }

      for (DocumentSnapshot doc in snapshot.docs) {
        Map<String, dynamic> dataMap = doc.data() as Map<String, dynamic>;
        reviews.add(ReviewModel.fromMap(dataMap));
      }

      return reviews;
    } catch (e) {
      throw Exception(e);
    }
  }
}
