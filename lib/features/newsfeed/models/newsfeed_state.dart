import 'package:lingo_news/features/newsfeed/models/article.dart';

class NewsfeedState {
  final List<Article> headlines;
  final bool isLoading;
  final String? error;

  NewsfeedState({
    required this.headlines,
    this.isLoading = false,
    this.error,
  });

  NewsfeedState copyWith({
    List<Article>? headlines,
    bool? isLoading,
    String? error,
  }) {
    return NewsfeedState(
      headlines: headlines ?? this.headlines,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}
