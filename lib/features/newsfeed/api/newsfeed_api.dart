import 'package:dio/dio.dart';

//TODO:Need to add this to Firebase Rmote config
const API_KEY = "902c7b94467b4478909d0484d1125d67";

class DioClient {
  final Dio _dio = Dio();

  DioClient() {
    _dio.options = BaseOptions(
      baseUrl: 'https://newsapi.org/v2',
      headers: {
        'x-api-key': API_KEY,
      },
    );
  }

  Dio get dio => _dio;
}
