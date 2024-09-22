import 'package:flutter/material.dart';
import 'package:lingo_news/features/home/presentation/widgets/article_list_card.dart';
import 'package:lingo_news/features/newsfeed/controller/newsfeed_provider.dart';
import 'package:lingo_news/features/newsfeed/models/article.dart';
import 'package:provider/provider.dart';

class TopHeadlinesWidget extends StatelessWidget {
  const TopHeadlinesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<NewsfeedProvider>().refreshHeadlines();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 22.0),
        child:
            Consumer<NewsfeedProvider>(builder: (context, newsProvider, child) {
          final state = newsProvider.state;
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (state.error != null && state.error!.isNotEmpty) {
            return Center(child: Text(state.error.toString()));
          } else if (state.headlines.isEmpty) {
            return const Center(child: Text("No headlines available"));
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Top Headlines",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.headlines.length,
                    itemBuilder: (context, index) {
                      Article article = state.headlines[index];
                      return ArticleListCard(article: article);
                    },
                  ),
                ),
              ],
            );
          }
        }),
      ),
    );
  }
}
