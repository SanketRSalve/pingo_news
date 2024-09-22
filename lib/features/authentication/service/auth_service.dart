import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lingo_news/core/utils/result_exception.dart';
import 'package:lingo_news/features/authentication/models/user_model.dart';
import 'package:lingo_news/features/authentication/utils/firebase_exceptions.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
  Future<Result<UserModel, Exception>> registerWithEmailAndPassword(
      String name, String email, String password) async {
    try {
      //create user
      final result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      //store user name
      await _firestore.collection('user').doc(result.user!.uid).set({
        'username': name,
      });

      return Success(UserModel.fromFirebaseUser(result.user!));
    } on FirebaseAuthException catch (e) {
      return Failure(Exception(handleAuthException(e)));
    } catch (e) {
      return Failure(Exception('An unknown error occured'));
    }
  }

  // Login with email & password
  Future<Result<UserModel, Exception>> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return Success(UserModel.fromFirebaseUser(result.user!));
    } on FirebaseAuthException catch (e) {
      return Failure(Exception(handleAuthException(e)));
    } catch (e) {
      return Failure(Exception('An Unknown error occured'));
    }
  }

  // signout user
  Future<Result<void, Exception>> signOut() async {
    try {
      await _auth.signOut();
      return const Success(null);
    } on FirebaseAuthException catch (e) {
      return Failure(Exception(handleAuthException(e)));
    } catch (e) {
      return Failure(Exception('An Unknown error occured'));
    }
  }
}
