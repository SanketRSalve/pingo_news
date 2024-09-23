import 'package:lingo_news/features/newsfeed/models/article.dart';
import 'package:lingo_news/features/newsfeed/respositories/news_repository.dart';

abstract class NewsServiceProto {
  Future<List<Article>> getTopHeadlines(String countryCode);
}

class NewsService implements NewsServiceProto {
  NewsRepository newsRepository;
  NewsService({required this.newsRepository});
  @override
  Future<List<Article>> getTopHeadlines(String countryCode) async {
    try {
      final response = await newsRepository.fetchTopHeadlines(countryCode);
      List<dynamic> articlesjson = response.data['articles'];
      List<Article> articles =
          articlesjson.map((json) => Article.fromJson(json)).toList();
      return articles;
    } catch (e) {
      rethrow;
    }
  }
}
