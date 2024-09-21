import 'package:flutter/material.dart';
import 'package:lingo_news/features/authentication/presentation/widgets/login_widget.dart';
import 'package:lingo_news/features/authentication/presentation/widgets/signup_widget.dart';

//Enum to handle AuthScreen
enum AuthenticationMode {
  login,
  signup,
}

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  //Default Auth Screen
  final AuthenticationMode authMode = AuthenticationMode.signup;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: authMode == AuthenticationMode.login
          ? const SignupWidget()
          : const LoginWidget(),
    );
  }
}
