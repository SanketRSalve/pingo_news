//API

import 'package:dio/dio.dart';
import 'package:lingo_news/features/newsfeed/api/newsfeed_api.dart';
import 'package:lingo_news/features/newsfeed/models/article.dart';

class NewsfeedRepository {
  final DioClient _dioClient;

  NewsfeedRepository(this._dioClient);

  // Fetch headlines
  Future<List<Article>> fetchTopHeadlines() async {
    final dio = _dioClient.dio;
    try {
      Response response = await dio.get('/top-headlines', queryParameters: {
        //TODO: make use of remote cofig to change this later
        'country': 'us',
      });
      List<dynamic> articlesJson = response.data['articles'];
      List<Article> articles =
          articlesJson.map((json) => Article.fromJson(json)).toList();
      print(response);
      return articles;
    } catch (e) {
      rethrow;
    }
  }
}
