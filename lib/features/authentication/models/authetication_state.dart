import 'package:lingo_news/features/authentication/models/user_model.dart';

class AuthenticationState {
  final UserModel? user;
  final bool isLoading;

  AuthenticationState({this.user, this.isLoading = false});

  AuthenticationState copyWith({UserModel? user, bool? isLoading}) {
    return AuthenticationState(
      user: user,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
