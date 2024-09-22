import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:lingo_news/features/authentication/models/authetication_state.dart';
import 'package:lingo_news/features/authentication/models/user_model.dart';
import 'package:lingo_news/features/authentication/service/authentication_service.dart';

class AuthenticationController extends ChangeNotifier {
  final AuthenticationService _authService = AuthenticationService();

  //Initialize state class
  AuthenticationState _state = AuthenticationState();
  AuthenticationState get state => _state;

  void initialize() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        _state = _state.copyWith(user: UserModel.fromFirebaseUser(user));
      } else {
        _state = _state.copyWith(user: null);
      }
      notifyListeners();
    });
  }

  Future<void> registerWithEmailAndPassword(
      String name, String email, String password) async {
    _state = _state.copyWith(isLoading: true);
    notifyListeners();
    try {
      final newUser = await _authService.registerWithEmailAndPassword(
          name, email, password);
      _state = _state.copyWith(user: newUser, isLoading: false);
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    _state = _state.copyWith(isLoading: true);
    notifyListeners();
    try {
      final user =
          await _authService.loginWithEmailAndPassword(email, password);
      _state = _state.copyWith(user: user, isLoading: false);
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> signOut() async {
    _state = _state.copyWith(isLoading: true);
    notifyListeners();
    try {
      await _authService.signOut();
      _state = _state.copyWith(user: null, isLoading: false);
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      notifyListeners();
    }
  }
}
