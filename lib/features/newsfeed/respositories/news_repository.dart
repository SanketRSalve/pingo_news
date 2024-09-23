import 'package:dio/dio.dart';
import 'package:lingo_news/features/newsfeed/api/newsfeed_api.dart';

abstract class NewsRepositoryProto {
  Future<Response> fetchTopHeadlines(String countryCode);
}

class NewsRepository implements NewsRepositoryProto {
  final DioClient dioClient;
  NewsRepository({required this.dioClient});

  @override
  Future<Response> fetchTopHeadlines(String countryCode) async {
    final dio = dioClient.dio;
    try {
      Response response = await dio.get('/top-headlines', queryParameters: {
        'country': countryCode,
      });
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
