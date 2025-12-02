class HashtagHelper {
  static List<String> extractHashtags(String text) {
    if (text.isEmpty) return [];

    final regex = RegExp(r'#\w+');
    final matches = regex.allMatches(text);
    final hashtags = matches.map((match) => match.group(0)!).toList();

    return hashtags.toSet().toList();
  }

  static String formatHashtags(List<String> hashtags) {
    return hashtags.join(', ');
  }

  static List<String> parseHashtags(String hashtagString) {
    if (hashtagString.trim().isEmpty) return [];

    return hashtagString
        .split(',')
        .map((tag) => tag.trim())
        .where((tag) => tag.isNotEmpty)
        .toList();
  }

  static bool isValidHashtag(String tag) {
    return tag.startsWith('#') && tag.length > 1;
  }
}
