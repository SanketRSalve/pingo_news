import 'package:lingo_news/features/authentication/models/user_model.dart';
import 'package:lingo_news/features/authentication/repositories/authentication_repository.dart';

abstract class AuthenticationServiceProto {
  Future<UserModel> registerWithEmailAndPassword(
      String name, String email, String password);
  Future<UserModel> loginWithEmailAndPassword(String email, String password);
  Future<void> signOut();
  Future<UserModel?> getCurrentUser();
}

class AuthenticationService implements AuthenticationServiceProto {
  AuthenticationService({required this.authRepository});
  final AuthenticationRepository authRepository;

  @override
  Future<UserModel> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      final userCredential =
          await authRepository.loginWithEmailAndPassword(email, password);
      return UserModel.fromFirebaseUser(userCredential.user!);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<UserModel> registerWithEmailAndPassword(
      String name, String email, String password) async {
    try {
      final userCredential = await authRepository.registerWithEmailAndPassword(
          name, email, password);
      return UserModel.fromFirebaseUser(userCredential.user!);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    authRepository.signOut();
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    final user = await authRepository.getCurrentUser();
    if (user != null) {
      return UserModel.fromFirebaseUser(user);
    } else {
      return null;
    }
  }
}
