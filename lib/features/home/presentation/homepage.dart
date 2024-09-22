import 'package:flutter/material.dart';
import 'package:lingo_news/app_sizes.dart';
import 'package:lingo_news/core/theme/colors.dart';
import 'package:lingo_news/features/home/presentation/widgets/top_headlines_widget.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryBlue,
          centerTitle: false,
          title: const Text(
            "MyNews",
            style: TextStyle(color: Colors.white),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Row(
                children: [
                  Icon(
                    Icons.near_me_rounded,
                    color: Colors.white,
                  ),
                  gapW8,
                  Text(
                    "In",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            )
          ],
        ),
        body: const TopHeadlinesWidget());
  }
}
