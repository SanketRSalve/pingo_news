import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lingo_news/features/authentication/controller/auth_provider.dart';
import 'package:lingo_news/features/authentication/presentation/widgets/login_widget.dart';
import 'package:lingo_news/features/authentication/presentation/widgets/signup_widget.dart';
import 'package:lingo_news/features/home/presentation/homepage.dart';
import 'package:provider/provider.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => Consumer<AuthProvider>(
          builder: (context, authProvider, _) {
            final authState = authProvider.state;
            if (authState.isLoading) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (authState.user != null) {
              return const HomePage();
            }
            return const LoginWidget();
          },
        ),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const SignupWidget(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomePage(),
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) {
      final bool loggedIn =
          Provider.of<AuthProvider>(context, listen: false).state.user != null;
      final bool isLoginRoute = state.matchedLocation == '/';
      final bool isRegisterRoute = state.matchedLocation == '/register';

      if (!loggedIn && !isLoginRoute && !isRegisterRoute) {
        return '/';
      } else if (loggedIn && (isLoginRoute || isRegisterRoute)) {
        return '/home';
      } else {
        return null;
      }
    },
  );
}
