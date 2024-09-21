import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text("HomePage"),
          TextButton(
              onPressed: () {
                debugPrint("LogOut");
              },
              child: const Text("Log Out"))
        ],
      ),
    );
  }
}
