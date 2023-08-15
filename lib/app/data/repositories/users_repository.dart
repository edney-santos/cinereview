import 'package:cinereview/app/data/database/db_firestore.dart';
import 'package:cinereview/app/data/models/info_model.dart';
import 'package:cinereview/app/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UsersRepository extends ChangeNotifier {
  late FirebaseFirestore db;
  late AuthService auth;

  UsersRepository({required this.auth}) {
    _startRepository();
  }

  _startRepository() async {
    await _startFirestore();
    await readInfo();
  }

  _startFirestore() {
    db = DBFirestore.get();
  }

  readInfo() async {
    if (auth.user != null) {
      final snapshot = await db
          .collection('users/${auth.user!.uid}/info')
          .doc(auth.user!.uid)
          .get();
      UsersInfo info = UsersInfo(
        name: snapshot.data()!.values.toList()[1],
        favGenre: snapshot.data()!.values.toList()[0],
      );
      return info;
    }
  }

  saveInfo(UsersInfo newInfo) async {
    await db
        .collection('users/${auth.user!.uid}/info')
        .doc(auth.user!.uid)
        .set({'name': newInfo.name, 'favGenre': newInfo.favGenre});
    notifyListeners();
  }

  updateInfo(UsersInfo newInfo) async {
    await db
        .collection('users/${auth.user!.uid}/info')
        .doc(auth.user!.uid)
        .update({'name': newInfo.name, 'favGenre': newInfo.favGenre});
    notifyListeners();
  }

  isFavorite(String movieId) async {
    final DocumentReference document =
        db.doc('users/${auth.user!.uid}/favorites/${auth.user!.uid}');

    final DocumentSnapshot snapshot = await document.get();
    final data = snapshot.data() as Map<String, dynamic>;
    final List<dynamic> favorites = data['favorites'];

    final isFavorited =
        favorites.firstWhere((movie) => movie == movieId, orElse: () => false);

    if (isFavorited == false) {
      return false;
    } else {
      return true;
    }
  }

  toggleFavorites(String movieId) async {
    final DocumentReference document =
        db.doc('users/${auth.user!.uid}/favorites/${auth.user!.uid}');

    final DocumentSnapshot snapshot = await document.get();
    final data = snapshot.data() as Map<String, dynamic>;
    final List<dynamic> favorites = data['favorites'];

    final isFavorited =
        favorites.firstWhere((movie) => movie == movieId, orElse: () => false);

    if (isFavorited == false) {
      document.update({
        'favorites': FieldValue.arrayUnion([movieId])
      });
    } else {
      document.update({
        'favorites': FieldValue.arrayRemove([movieId])
      });
    }
  }
}
