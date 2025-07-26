import 'package:flutter/foundation.dart';

@immutable
final class StringUtils {
  const StringUtils._();

  static String fixImageUrl(String url) {
    return url
        .replaceFirst(
          'http://ia.media-imdb.com/',
          'https://m.media-amazon.com/',
        )
        .replaceAll('@..jpg', '@._V1_.jpg');
  }
}
