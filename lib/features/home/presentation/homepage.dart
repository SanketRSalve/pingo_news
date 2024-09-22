import 'package:flutter/material.dart';
import 'package:lingo_news/core/theme/app_sizes.dart';
import 'package:lingo_news/core/theme/colors.dart';
import 'package:lingo_news/core/utils/title_case_string_extenstion.dart';
import 'package:lingo_news/features/home/presentation/widgets/top_headlines_widget.dart';
import 'package:lingo_news/features/newsfeed/controller/newsfeed_provider.dart';
import 'package:provider/provider.dart';

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
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Row(
                children: [
                  const Icon(
                    Icons.near_me_rounded,
                    color: Colors.white,
                  ),
                  gapW8,
                  Consumer<NewsfeedProvider>(
                      builder: (context, newsfeedProvider, child) {
                    final countryCode = newsfeedProvider.countryCode;
                    return Text(
                      countryCode.toTitleCase(),
                      style: const TextStyle(color: Colors.white),
                    );
                  })
                ],
              ),
            )
          ],
        ),
        body: const TopHeadlinesWidget());
  }
}
