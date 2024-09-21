import 'package:flutter/material.dart';
import 'package:lingo_news/features/authentication/controller/auth_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text("HomePage"),
            TextButton(
                onPressed: () {
                  debugPrint("LogOut");
                  context.read<AuthProvider>().signOut();
                },
                child: const Text("Log Out"))
          ],
        ),
      ),
    );
  }
}
