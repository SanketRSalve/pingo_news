import 'package:dio/dio.dart';
import 'package:lingo_news/core/utils/result_exception.dart';
import 'package:lingo_news/features/newsfeed/api/newsfeed_api.dart';
import 'package:lingo_news/features/newsfeed/models/article.dart';

class NewsfeedRepository {
  final DioClient _dioClient;

  NewsfeedRepository(this._dioClient);

  // Fetch headlines
  Future<Result<List<Article>, Exception>> fetchTopHeadlines(
      String countryCode) async {
    final dio = _dioClient.dio;

    try {
      Response response = await dio.get('/top-headlines', queryParameters: {
        'country': countryCode,
      });
      //Response response = await Dio().get('http://127.0.0.1:5500/test.json');
      if (response.statusCode == 200) {
        List<dynamic> articlesjson = response.data['articles'];
        List<Article> articles =
            articlesjson.map((json) => Article.fromJson(json)).toList();
        return Success(articles);
      } else {
        return Failure(Exception(response.statusMessage));
      }
    } on DioException catch (e) {
      return Failure(Exception('Network error: ${e.message}'));
    } on Exception catch (e) {
      return Failure(e);
    }
  }
}
