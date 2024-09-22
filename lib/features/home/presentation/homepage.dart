import 'package:flutter/material.dart';
import 'package:lingo_news/app_sizes.dart';
import 'package:lingo_news/core/theme/colors.dart';
import 'package:lingo_news/features/newsfeed/controller/newsfeed_provider.dart';
import 'package:lingo_news/features/newsfeed/models/article.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsfeedProvider>(context);
    newsProvider.fetchHeadlines();
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
        body: Column(
          children: [
            const Text(
              "Top Headlines",
              style: TextStyle(color: Colors.black),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: newsProvider.headlines.length,
                itemBuilder: (context, index) {
                  Article article = newsProvider.headlines[index];
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 6.0),
                    margin: const EdgeInsets.only(top: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(article.title),
                              Text(
                                article.description ?? "No Description",
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(article.publishedAt.toString()),
                            ],
                          ),
                        ),
                        gapW16,
                        Container(
                          height: MediaQuery.of(context).size.width * 0.3,
                          width: MediaQuery.of(context).size.width * 0.3,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      article.urlToImage.toString()),
                                  fit: BoxFit.cover)),
                        )
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ));
  }
}
