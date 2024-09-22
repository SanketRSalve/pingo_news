import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lingo_news/core/routing/app_router.dart';
import 'package:lingo_news/core/theme/app_theme.dart';
import 'package:lingo_news/features/authentication/controller/auth_provider.dart';
import 'package:lingo_news/features/authentication/service/auth_service.dart';
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
    final authService = AuthService();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider(authService)),
        ChangeNotifierProvider(
            create: (_) => NewsfeedProvider(newsfeedRepository))
      ],
      child: MaterialApp.router(
        //Default Theme : Light
        routerConfig: AppRouter.router,
        themeMode: ThemeMode.light,
        theme: AppTheme.lightTheme,
      ),
    );
  }
}
