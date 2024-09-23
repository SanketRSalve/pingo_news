import 'package:flutter/foundation.dart';
import 'package:lingo_news/core/firebase_remote_service/firebase_remote_service.dart';
import 'package:lingo_news/features/newsfeed/models/newsfeed_state.dart';
import 'package:lingo_news/features/newsfeed/service/news_service.dart';

class NewsController extends ChangeNotifier {
  final NewsService _newsService;
  final FirebaseRemoteService _firebaseRemoteService;
  String _countryCode = '';

  NewsfeedState _state;
  NewsfeedState get state => _state;
  String get countryCode => _countryCode;

  NewsController(this._newsService, this._firebaseRemoteService)
      : _state = NewsfeedState(headlines: []) {
    _initCountryCode();
  }

  Future<void> _initCountryCode() async {
    _state = _state.copyWith(isLoading: true);
    notifyListeners();

    try {
      _countryCode = await _firebaseRemoteService.fetchCountryCode();
      await fetchHeadlines();
    } catch (e) {
      _state = _state.copyWith(
        error: 'Failed to initialize country code: ${e.toString()}',
        isLoading: false,
      );
      notifyListeners();
    }
  }

  Future<void> fetchHeadlines() async {
    if (_countryCode.isEmpty) {
      _state = _state.copyWith(
          error: 'Country code not initialized', isLoading: false);
      notifyListeners();
      return;
    }

    _state = _state.copyWith(isLoading: true, error: null);
    notifyListeners();

    try {
      final result = await _newsService.getTopHeadlines(_countryCode);
      _state = _state.copyWith(headlines: result, isLoading: false);
      notifyListeners();
    } catch (e) {
      _state = _state.copyWith(
          error: 'An unexpected error occurred: ${e.toString()}',
          isLoading: false);
    }
    notifyListeners();
  }

  Future<void> refreshHeadlines() async {
    await _initCountryCode();
  }
}
