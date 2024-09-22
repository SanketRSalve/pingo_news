import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lingo_news/features/authentication/controller/auth_provider.dart';
import 'package:lingo_news/features/authentication/presentation/widgets/login_widget.dart';
import 'package:lingo_news/features/authentication/presentation/widgets/signup_widget.dart';
import 'package:lingo_news/features/home/presentation/homepage.dart';
import 'package:provider/provider.dart';

class AppRouter {
  static final rootNavigatorKey = GlobalKey<NavigatorState>();

  static GoRouter router(BuildContext context) {
    final authProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    return GoRouter(
      debugLogDiagnostics: true,
      navigatorKey: rootNavigatorKey,
      refreshListenable: authProvider,
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginWidget(),
        ),
        GoRoute(
          path: '/register',
          builder: (context, state) => const SignupWidget(),
        ),
      ],
      redirect: (context, state) {
        final authProvider =
            Provider.of<AuthenticationProvider>(context, listen: false);
        final bool isLoggedIn = authProvider.state.user != null;
        final bool isLoading = authProvider.state.isLoading;
        final bool isLoginRoute = state.matchedLocation == '/login';
        final bool isRegisterRoute = state.matchedLocation == '/register';

        if (isLoading) return null;

        if (!isLoggedIn && !isLoginRoute && !isRegisterRoute) {
          return '/login';
        } else if (isLoggedIn && (isLoginRoute || isRegisterRoute)) {
          return '/';
        } else {
          return null;
        }
      },
    );
  }
}
