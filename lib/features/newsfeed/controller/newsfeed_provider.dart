import 'package:flutter/material.dart';
import 'package:lingo_news/core/utils/result_exception.dart';
import 'package:lingo_news/core/firebase_remote_service/firebase_remote_service.dart';
import 'package:lingo_news/features/newsfeed/models/article.dart';
import 'package:lingo_news/features/newsfeed/models/newsfeed_state.dart';
import 'package:lingo_news/features/newsfeed/service/newsfeed_service.dart';

class NewsfeedProvider with ChangeNotifier {
  final NewsfeedRepository _newsRepository;
  final FirebaseRemoteService _firebaseRemoteService;
  String _countryCode = "";

  NewsfeedProvider(this._newsRepository, this._firebaseRemoteService)
      : _state = NewsfeedState(headlines: []) {
    _initCountryCode();
  }

  NewsfeedState _state;
  NewsfeedState get state => _state;
  String get countryCode => _countryCode;

  Future<void> _initCountryCode() async {
    _state = _state.copyWith(isLoading: true);
    notifyListeners();

    try {
      _countryCode = await _firebaseRemoteService.fetchCountryCode();
      await fetchHeadlines();
    } catch (e) {
      _state = _state.copyWith(
          error: 'Failed to initialize country code: ${e.toString()}',
          isLoading: false);
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
      final result = await _newsRepository.fetchTopHeadlines(_countryCode);
      if (result is Success<List<Article>, Exception>) {
        _state = _state.copyWith(headlines: result.value, isLoading: false);
      } else if (result is Failure<List<Article>, Exception>) {
        _state = _state.copyWith(
            error: result.exception.toString(), isLoading: false);
      }
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
