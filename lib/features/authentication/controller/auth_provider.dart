import 'package:flutter/material.dart';
import 'package:lingo_news/core/utils/result_exception.dart';
import 'package:lingo_news/features/authentication/models/auth_state.dart';
import 'package:lingo_news/features/authentication/models/user_model.dart';
import 'package:lingo_news/features/authentication/service/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService;

  AuthState _state;
  AuthState get state => _state;

  AuthProvider(this._authService)
      : _state = AuthState(user: null, isLoading: false, errorMessage: "");

  Future<void> init() async {
    _state = _state.copyWith(isLoading: true, errorMessage: "");
    notifyListeners();

    try {
      _authService.user.listen((user) {
        _state = _state.copyWith(user: user, isLoading: false);
      });
    } catch (e) {
      _state = _state.copyWith(
          errorMessage: 'Failed to initialize authencticaion: ${e.toString()}',
          isLoading: false);
      notifyListeners();
    }
  }

  Future<bool> loginUser(String email, String password) async {
    _state = _state.copyWith(isLoading: true);
    notifyListeners();

    final result =
        await _authService.signInWithEmailAndPassword(email, password);
    if (result is Success<UserModel, Exception>) {
      _state = _state.copyWith(user: result.value, isLoading: false);
      notifyListeners();
      return true;
    } else if (result is Failure<UserModel, Exception>) {
      _state = _state.copyWith(
          errorMessage: result.exception.toString(), isLoading: false);
      notifyListeners();
      return false;
    }
    return false;
  }

  Future<bool> registerUser(String email, String password) async {
    _state = _state.copyWith(isLoading: true);
    notifyListeners();

    final result =
        await _authService.registerWithEmailAndPassword(email, password);
    if (result is Success<UserModel, Exception>) {
      _state = _state.copyWith(user: result.value, isLoading: false);
      notifyListeners();
      return true;
    } else if (result is Failure<UserModel, Exception>) {
      _state = _state.copyWith(
          errorMessage: result.exception.toString(), isLoading: false);
      notifyListeners();
      return false;
    }
    return false;
  }

  Future<void> signOut() async {
    _state = _state.copyWith(isLoading: true);
    notifyListeners();
    final result = await _authService.signOut();
    if (result is Success<void, Exception>) {
      _state = _state.copyWith(user: null, isLoading: false);
      notifyListeners();
    } else if (result is Failure<void, Exception>) {
      _state = _state.copyWith(
          errorMessage: result.exception.toString(), isLoading: false);
      notifyListeners();
    }
  }
}
