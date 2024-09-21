import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lingo_news/features/authentication/models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Stream to get authentication state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Get Current User
  UserModel? get currentUser {
    final user = _auth.currentUser;
    if (user != null) {
      return UserModel.fromFirebaseUser(user);
    }
    return null;
  }

  // Auth State changes stream
  Stream<UserModel?> get user {
    return _auth.authStateChanges().map((firebaseUser) {
      return firebaseUser == null
          ? null
          : UserModel.fromFirebaseUser(firebaseUser);
    });
  }

  // Register with email & password
  Future<UserModel?> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return UserModel.fromFirebaseUser(result.user!);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  // Login with email & password
  Future<UserModel?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return UserModel.fromFirebaseUser(result.user!);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  // signout user
  Future<void> signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
