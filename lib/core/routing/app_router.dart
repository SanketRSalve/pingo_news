import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lingo_news/features/authentication/controller/authentication_controller.dart';
import 'package:lingo_news/features/authentication/presentation/widgets/login_widget.dart';
import 'package:lingo_news/features/authentication/presentation/widgets/signup_widget.dart';
import 'package:lingo_news/features/home/presentation/homepage.dart';
import 'package:provider/provider.dart';

class AppRouter {
  static final rootNavigatorKey = GlobalKey<NavigatorState>();

  static GoRouter router(BuildContext context) {
    final authProvider =
        Provider.of<AuthenticationController>(context, listen: false);

    return GoRouter(
      debugLogDiagnostics: true,
      navigatorKey: rootNavigatorKey,
      refreshListenable: authProvider,
      initialLocation: '/login',
      routes: [
        GoRoute(
          path: '/',
          name: 'home',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/login',
          name: 'login',
          builder: (context, state) => const LoginWidget(),
        ),
        GoRoute(
          path: '/register',
          name: 'register',
          builder: (context, state) => const SignupWidget(),
        ),
      ],
      redirect: (BuildContext context, GoRouterState state) {
        final authProvider =
            Provider.of<AuthenticationController>(context, listen: false);
        final bool isLoggedIn = authProvider.state.user != null;
        final bool isLoading = authProvider.state.isLoading;

        final bool isGoingToLogin = state.matchedLocation == '/login';
        final bool isGoingToRegister = state.matchedLocation == '/register';

        if (isLoading) return null;
        if (isLoggedIn && (isGoingToLogin || isGoingToRegister)) {
          return '/';
        }
        if (!isLoggedIn && !isGoingToLogin && !isGoingToRegister) {
          return '/login';
        }
        return null;
      },
      errorBuilder: (context, state) => Scaffold(
        body: Center(
          child: Text('No route defined for ${state.matchedLocation}'),
        ),
      ),
    );
  }
}
