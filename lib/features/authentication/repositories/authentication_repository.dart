import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationRepositoryProto {
  Future<UserCredential> registerWithEmailAndPassword(
      String name, String email, String password);
  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password);
  Future<void> signOut();
}

class AuthenticationRepository implements AuthenticationRepositoryProto {
  AuthenticationRepository({required this.firestore, required this.auth});

  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  @override
  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      final userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (_) {
      rethrow;
    }
  }

  @override
  Future<UserCredential> registerWithEmailAndPassword(
      String name, String email, String password) async {
    try {
      final userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await firestore.collection('user').doc(userCredential.user!.uid).set({
        'username': name,
      });
      return userCredential;
    } on FirebaseAuthException catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    await auth.signOut();
  }

  Future<User?> getCurrentUser() async {
    User? user = auth.currentUser;
    if (user != null) {
      return user;
    }
    return null;
  }
}
