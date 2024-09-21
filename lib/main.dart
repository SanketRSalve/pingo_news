import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lingo_news/core/theme/app_theme.dart';
import 'package:lingo_news/features/authentication/presentation/auth_screen.dart';
import 'package:lingo_news/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //Default Theme : Light
      themeMode: ThemeMode.light,
      theme: AppTheme.lightTheme,
      home: const AuthScreen(),
    );
  }
}
