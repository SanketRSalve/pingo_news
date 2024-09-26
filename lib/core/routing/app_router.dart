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
        Provider.of<AuthenticationController>(context, listen: true);

    return GoRouter(
      debugLogDiagnostics: true,
      navigatorKey: rootNavigatorKey,
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          name: 'root',
          builder: (context, state) {
            return const LoginWidget();
          },
          routes: [
            GoRoute(
              path: 'home',
              name: 'home',
              builder: (context, state) {
                return const HomePage();
              },
            ),
            GoRoute(
              path: 'login',
              name: 'login',
              builder: (context, state) {
                return const LoginWidget();
              },
            ),
            GoRoute(
              path: 'register',
              name: 'register',
              builder: (context, state) {
                return const SignupWidget();
              },
            ),
          ],
        ),
      ],
      redirect: (BuildContext context, GoRouterState state) {
        final isLoggedIn = authProvider.state.user != null;
        final isLoading = authProvider.state.isLoading;

        if (isLoading) {
          return null;
        }

        final isAuthPage = state.matchedLocation == '/' ||
            state.matchedLocation == '/login' ||
            state.matchedLocation == '/register';

        if (isLoggedIn && isAuthPage) {
          return '/home';
        }
        if (!isLoggedIn && !isAuthPage) {
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
