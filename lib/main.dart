import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lingo_news/core/routing/app_router.dart';
import 'package:lingo_news/core/theme/app_theme.dart';
import 'package:lingo_news/features/authentication/controller/authentication_controller.dart';
import 'package:lingo_news/core/firebase_remote_service/firebase_remote_service.dart';
import 'package:lingo_news/features/newsfeed/api/newsfeed_api.dart';
import 'package:lingo_news/features/newsfeed/controller/news_controller.dart';
import 'package:lingo_news/features/newsfeed/respositories/news_repository.dart';
import 'package:lingo_news/features/newsfeed/service/news_service.dart';
import 'package:lingo_news/firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (kDebugMode) {
    // Use local Firebase emulators if in DEBUG mode.
    try {
      FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
      await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseRemoteService().fetchApiKey(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              final apiKey = snapshot.data!;
              final dioClient = DioClient(apiKey: apiKey);
              final firebaseRemoteService = FirebaseRemoteService();
              final newsRepository = NewsRepository(dioClient: dioClient);
              final newsService = NewsService(newsRepository: newsRepository);
              return MultiProvider(
                providers: [
                  ChangeNotifierProvider(
                      create: (_) => AuthenticationController()..initialize()),
                  ChangeNotifierProvider(
                      create: (_) =>
                          NewsController(newsService, firebaseRemoteService)),
                ],
                child: Consumer(
                  builder: (context, authProvider, child) {
                    return MaterialApp.router(
                      //Default Theme : Light
                      debugShowCheckedModeBanner: false,
                      routerConfig: AppRouter.router(context),
                      themeMode: ThemeMode.light,
                      theme: AppTheme.lightTheme,
                    );
                  },
                ),
              );
            } else {
              return MaterialApp(
                home: Scaffold(
                  body: Center(
                    child: Text('Failed to initialize app: ${snapshot.error}'),
                  ),
                ),
              );
            }
          } else {
            return const MaterialApp(
              home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          }
        });
  }
}
