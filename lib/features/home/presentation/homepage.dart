import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lingo_news/core/theme/app_sizes.dart';
import 'package:lingo_news/core/theme/colors.dart';
import 'package:lingo_news/features/authentication/controller/authentication_controller.dart';
import 'package:lingo_news/features/home/presentation/widgets/top_headlines_widget.dart';
import 'package:lingo_news/features/newsfeed/controller/news_controller.dart';
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
            style: TextStyle(
              color: AppColors.surfaceLight,
              fontFamily: 'Poppins',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
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
                  Consumer<NewsController>(
                      builder: (context, newsfeedProvider, child) {
                    final countryCode = newsfeedProvider.countryCode;
                    return Text(
                      countryCode.toUpperCase(),
                      style: const TextStyle(
                        color: AppColors.surfaceLight,
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  })
                ],
              ),
            ),

            //Can Add Logout button if asked
            TextButton(
                onPressed: () async {
                  await context
                      .read<AuthenticationController>()
                      .signOut(context);
                },
                child: const Text(
                  "Logout",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Poppins",
                    fontSize: 12,
                    fontStyle: FontStyle.normal,
                  ),
                ))
          ],
        ),
        body: const TopHeadlinesWidget());
  }
}
