import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lingo_news/core/routing/app_router.dart';
import 'package:lingo_news/core/theme/app_theme.dart';
import 'package:lingo_news/features/authentication/controller/auth_provider.dart';
import 'package:lingo_news/features/authentication/service/auth_service.dart';
import 'package:lingo_news/core/firebase_remote_service/firebase_remote_service.dart';
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
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final dioClient = DioClient();
    final newsfeedRepository = NewsfeedRepository(dioClient);
    final authService = AuthService();
    final firebaseRemoteService = FirebaseRemoteService();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => AuthProvider(authService)..init()),
        ChangeNotifierProvider(
            create: (_) =>
                NewsfeedProvider(newsfeedRepository, firebaseRemoteService)),
      ],
      child: Consumer(builder: (context, authProvider, child) {
        return MaterialApp.router(
          //Default Theme : Light
          debugShowCheckedModeBanner: false,
          routerConfig: AppRouter.router(context),
          themeMode: ThemeMode.light,
          theme: AppTheme.lightTheme,
        );
      }),
    );
  }
}
