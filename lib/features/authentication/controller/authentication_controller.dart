import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lingo_news/features/authentication/models/authetication_state.dart';
import 'package:lingo_news/features/authentication/models/user_model.dart';
import 'package:lingo_news/features/authentication/service/authentication_service.dart';
import 'package:lingo_news/features/authentication/utils/firebase_exceptions.dart';

class AuthenticationController extends ChangeNotifier {
  final AuthenticationService _authenticationService;

  AuthenticationController(this._authenticationService) {
    _initializeState();
  }

  // Initialize state class
  AuthenticationState _state = AuthenticationState();
  AuthenticationState get state => _state;

  Future<void> _initializeState() async {
    final currentUser = await _authenticationService.getCurrentUser();
    _updateState(user: currentUser, isLoading: false);
  }

  void _updateState({UserModel? user, bool? isLoading}) {
    _state = _state.copyWith(
      user: user,
      isLoading: isLoading ?? _state.isLoading,
    );

    notifyListeners();
  }

  // Register with email and password
  Future<void> registerWithEmailAndPassword(
    String name,
    String email,
    String password,
    BuildContext context,
  ) async {
    _updateState(isLoading: true);
    try {
      final newUser = await _authenticationService.registerWithEmailAndPassword(
        name,
        email,
        password,
      );
      _updateState(user: newUser, isLoading: false);
    } catch (e) {
      final errorMessage = handleAuthException(e as FirebaseAuthException);
      debugPrint(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(errorMessage),
      ));
      _updateState(user: null, isLoading: false);
    }
  }

  // Login with email and password
  Future<void> loginWithEmailAndPassword(
    String email,
    String password,
    BuildContext context,
  ) async {
    _updateState(isLoading: true);
    try {
      final user = await _authenticationService.loginWithEmailAndPassword(
        email,
        password,
      );
      _updateState(user: user, isLoading: false);
    } catch (e) {
      final errorMessage = handleAuthException(e as FirebaseAuthException);
      debugPrint(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(errorMessage),
      ));
      _updateState(user: null, isLoading: false);
    }
  }

  // Sign out
  Future<void> signOut(BuildContext context) async {
    _updateState(isLoading: true);

    try {
      await _authenticationService.signOut();
      _updateState(user: null, isLoading: false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Signed out successfully.')),
      );
    } catch (e) {
      final errorMessage = handleAuthException(e as FirebaseAuthException);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(errorMessage),
      ));
      _updateState(isLoading: false);
    }
  }
}
