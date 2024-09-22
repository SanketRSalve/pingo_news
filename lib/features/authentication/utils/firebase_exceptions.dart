import 'package:firebase_auth/firebase_auth.dart';

String handleAuthException(FirebaseAuthException e) {
  switch (e.code) {
    case 'invalid-email':
      return 'The email address is not valid.';
    case 'user-disabled':
      return 'This user has been disabled.';
    case 'user-not-found':
      return 'No user found with this email.';
    case 'wrong-password':
      return 'The password is incorrect.';
    case 'email-already-in-use':
      return 'The email address is already in use.';
    case 'operation-not-allowed':
      return 'Email/password accounts are not enabled.';
    case 'weak-password':
      return 'The password is too weak.';
    default:
      return 'An unknown error occurred.';
  }
}
