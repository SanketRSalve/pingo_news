import 'package:lingo_news/features/authentication/models/user_model.dart';
import 'package:lingo_news/features/authentication/repositories/authentication_repository.dart';

abstract class AuthenticationServiceProto {
  Future<UserModel> registerWithEmailAndPassword(
      String name, String email, String password);
  Future<UserModel> loginWithEmailAndPassword(String email, String password);
  Future<void> signOut();
}

class AuthenticationService implements AuthenticationServiceProto {
  final AuthenticationRepository _authRepo = AuthenticationRepository();

  @override
  Future<UserModel> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      final userCredential =
          await _authRepo.loginWithEmailAndPassword(email, password);
      return UserModel.fromFirebaseUser(userCredential.user!);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<UserModel> registerWithEmailAndPassword(
      String name, String email, String password) async {
    try {
      final userCredential =
          await _authRepo.registerWithEmailAndPassword(name, email, password);
      return UserModel.fromFirebaseUser(userCredential.user!);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _authRepo.signOut();
    } catch (e) {
      rethrow;
    }
  }
}
