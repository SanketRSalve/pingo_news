import 'package:flutter/material.dart';
import 'package:lingo_news/features/newsfeed/models/article.dart';
import 'package:lingo_news/features/newsfeed/service/newsfeed_service.dart';

class NewsfeedProvider with ChangeNotifier {
  final NewsfeedRepository _newsRepository;

  NewsfeedProvider(this._newsRepository);

  List<Article> _headlines = [];
  List<Article> get headlines => _headlines;

  bool _loading = false;
  bool get loading => _loading;

  Future<void> fetchHeadlines() async {
    _loading = true;
    notifyListeners();

    try {
      _headlines = await _newsRepository.fetchTopHeadlines();
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
