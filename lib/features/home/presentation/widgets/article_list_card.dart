import 'package:flutter/material.dart';
import 'package:lingo_news/core/theme/app_sizes.dart';
import 'package:lingo_news/core/theme/colors.dart';
import 'package:lingo_news/core/utils/dateTime_helper.dart';
import 'package:lingo_news/features/newsfeed/models/article.dart';

class ArticleListCard extends StatelessWidget {
  const ArticleListCard({super.key, required this.article});
  final Article article;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 6.0),
      margin: const EdgeInsets.only(top: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.source.name,
                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                gapH12,
                Text(
                  article.description ?? "No Description",
                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontStyle: FontStyle.normal,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                gapH12,
                Text(
                  article.publishedAt.toTimeAgoLabel(),
                  style: const TextStyle(
                    color: AppColors.labelLight,
                    fontFamily: 'Poppins',
                    fontSize: 10,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          gapW16,
          Container(
            height: MediaQuery.of(context).size.width * 0.3,
            width: MediaQuery.of(context).size.width * 0.3,
            decoration: BoxDecoration(
              color: AppColors.labelLight,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                article.urlToImage ?? '',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.broken_image,
                    size: 50,
                    color: AppColors.primaryBlue,
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
