import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lingo_news/features/authentication/models/authetication_state.dart';
import 'package:lingo_news/features/authentication/models/user_model.dart';
import 'package:lingo_news/features/authentication/service/authentication_service.dart';
import 'package:lingo_news/features/authentication/utils/firebase_exceptions.dart';

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
      String name, String email, String password, BuildContext context) async {
    _state = _state.copyWith(isLoading: true);
    notifyListeners();
    try {
      final newUser = await _authService.registerWithEmailAndPassword(
          name, email, password);
      _state = _state.copyWith(user: newUser, isLoading: false);
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(handleAuthException(e as FirebaseAuthException))));
                      _state = _state.copyWith(user: null, isLoading: false);
      notifyListeners();
    }
  }

  Future<void> loginWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    _state = _state.copyWith(isLoading: true);
    notifyListeners();
    try {
      final user =
          await _authService.loginWithEmailAndPassword(email, password);
      _state = _state.copyWith(user: user, isLoading: false);
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(handleAuthException(e as FirebaseAuthException))));
            _state = _state.copyWith(user: null, isLoading: false);
      notifyListeners();
    }
  }

  Future<void> signOut(BuildContext context) async {
    _state = _state.copyWith(isLoading: true);
    notifyListeners();
    try {
      await _authService.signOut();
      _state = _state.copyWith(user: null, isLoading: false);
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(handleAuthException(e as FirebaseAuthException))));
                      _state = _state.copyWith(user: null, isLoading: false);
      notifyListeners();
    }
  }
}
