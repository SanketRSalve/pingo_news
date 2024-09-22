import 'package:flutter/material.dart';
import 'package:lingo_news/core/utils/result_exception.dart';
import 'package:lingo_news/features/authentication/models/auth_state.dart';
import 'package:lingo_news/features/authentication/models/user_model.dart';
import 'package:lingo_news/features/authentication/service/auth_service.dart';

class AuthenticationProvider with ChangeNotifier {
  final AuthService _authService;

  AuthState _state;
  AuthState get state => _state;

  AuthenticationProvider(this._authService)
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
    try {
      final result =
          await _authService.signInWithEmailAndPassword(email, password);
      if (result is Success<UserModel, Exception>) {
        _state = _state.copyWith(user: result.value, isLoading: false);
      } else if (result is Failure<UserModel, Exception>) {
        _state = _state.copyWith(
          errorMessage: result.exception.toString(),
          isLoading: false,
        );
      }
      notifyListeners();
      return result is Success;
    } catch (e) {
      _state = _state.copyWith(
        errorMessage: e.toString(),
        isLoading: false,
      );
      notifyListeners();
      return false;
    }
  }

  Future<bool> registerUser(String name, String email, String password) async {
    _state = _state.copyWith(isLoading: true);
    notifyListeners();
    try {
      final result = await _authService.registerWithEmailAndPassword(
          name, email, password);
      if (result is Success<UserModel, Exception>) {
        _state = _state.copyWith(user: result.value, isLoading: false);
      } else if (result is Failure<UserModel, Exception>) {
        _state = _state.copyWith(
          errorMessage: result.exception.toString(),
          isLoading: false,
        );
      }
      notifyListeners();
      return result is Success;
    } catch (e) {
      _state = _state.copyWith(
        errorMessage: e.toString(),
        isLoading: false,
      );
      notifyListeners();
      return false;
    }
  }

  Future<void> signOut() async {
    _state = _state.copyWith(isLoading: true);
    notifyListeners();
    try {
      await _authService.signOut();
      notifyListeners();
    } catch (e) {
      _state = _state.copyWith(
        errorMessage: e.toString(),
        isLoading: false,
      );
    } finally {
      _state = _state.copyWith(isLoading: false);
      notifyListeners();
    }
  }
}
