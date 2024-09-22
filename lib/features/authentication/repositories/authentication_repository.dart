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
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
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
      final userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _firestore.collection('user').doc(userCredential.user!.uid).set({
        'username': name,
      });
      return userCredential;
    } on FirebaseAuthException catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
