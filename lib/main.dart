import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lingo_news/core/theme/app_theme.dart';
import 'package:lingo_news/features/authentication/controller/auth_provider.dart';
import 'package:lingo_news/features/authentication/presentation/widgets/login_widget.dart';
import 'package:lingo_news/features/authentication/presentation/widgets/signup_widget.dart';
import 'package:lingo_news/features/home/presentation/homepage.dart';
import 'package:lingo_news/features/newsfeed/api/newsfeed_api.dart';
import 'package:lingo_news/features/newsfeed/controller/newsfeed_provider.dart';
import 'package:lingo_news/features/newsfeed/service/newsfeed_service.dart';
import 'package:lingo_news/firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final dioClient = DioClient();
    final newsfeedRepository = NewsfeedRepository(dioClient);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(
            create: (_) => NewsfeedProvider(newsfeedRepository))
      ],
      child: MaterialApp.router(
        //Default Theme : Light
        routerConfig: _router,
        themeMode: ThemeMode.light,
        theme: AppTheme.lightTheme,
      ),
    );
  }

  // Handle Routing
  final GoRouter _router = GoRouter(
      debugLogDiagnostics: true,
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => Consumer<AuthProvider>(
            builder: (context, authProvider, _) {
              if (authProvider.isLoading) {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (authProvider.user != null) {
                return const HomePage();
              }
              return const LoginWidget();
            },
          ),
        ),
        GoRoute(
            path: '/register',
            builder: (context, state) => const SignupWidget()),
        GoRoute(path: '/home', builder: (context, state) => const HomePage())
      ],
      redirect: (BuildContext context, GoRouterState state) {
        final bool loggedIn =
            Provider.of<AuthProvider>(context, listen: false).user != null;
        final bool isLoginRoute = state.matchedLocation == '/';
        final bool isRegisterRoute = state.matchedLocation == '/register';

        //if not logged in, redirect to login page
        if (!loggedIn && !isLoginRoute && !isRegisterRoute) {
          return '/';
        }
        //if user is logged in redirect to homepage
        else if (loggedIn && (isLoginRoute || isRegisterRoute)) {
          return '/home';
        } else {
          return null;
        }
      });
}
