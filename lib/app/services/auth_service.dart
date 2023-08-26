import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthException implements Exception {
  String message;
  AuthException(this.message);
}

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  bool isLoading = true;

  AuthService() {
    _authCheck();
  }

  void _authCheck() {
    _auth.authStateChanges().listen((User? fireUser) {
      user = (fireUser == null) ? null : fireUser;
      isLoading = false;
      notifyListeners();
    });
  }

  void _getUser() {
    user = _auth.currentUser;
    notifyListeners();
  }

  Future<void> register(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _getUser();
    } on FirebaseAuthException catch (error) {
      if (error.code == 'week-password') {
        throw AuthException('Senha muito fraca!');
      }

      if (error.code == 'email-already-in-use') {
        throw AuthException('E-mail já cadastrado!');
      }
    }
  }

  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _getUser();
    } on FirebaseAuthException catch (error) {
      if (error.code == 'user-not-found') {
        throw AuthException('Usuário não encontrado');
      }

      if (error.code == 'wrong-password') {
        throw AuthException('Senha incorreta, tente novamente');
      }
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    _getUser();
  }
}
