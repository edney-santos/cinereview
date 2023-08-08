import 'package:cinereview/database/db_firestore.dart';
import 'package:cinereview/models/users_info.dart';
import 'package:cinereview/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UsersRepository extends ChangeNotifier {
  UsersInfo info = UsersInfo(name: '', favGenre: '');
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
      info = UsersInfo(
        name: snapshot.data()!.values.toList()[1],
        favGenre: snapshot.data()!.values.toList()[0],
      );
    }
  }

  saveInfo(UsersInfo newInfo) async {
    await db
        .collection('users/${auth.user!.uid}/info')
        .doc(auth.user!.uid)
        .set({'name': newInfo.name, 'favGenre': newInfo.favGenre});
    notifyListeners();
  }
}
