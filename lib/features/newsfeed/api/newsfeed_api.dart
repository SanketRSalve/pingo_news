import 'package:dio/dio.dart';

class DioClient {
  final Dio _dio = Dio();

  DioClient({required String apiKey}) {
    _dio.options = BaseOptions(
      baseUrl: 'https://newsapi.org/v2',
      headers: {
        'x-api-key': apiKey,
      },
    );
  }

  Dio get dio => _dio;
}
