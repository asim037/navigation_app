class HashtagSuggestions {
  static final List<String> _popularHashtags = [
    '#flutter',
    '#dart',
    '#coding',
    '#programming',
    '#developer',
    '#tech',
    '#mobile',
    '#app',
    '#design',
    '#ui',
    '#ux',
    '#software',
    '#web',
    '#javascript',
    '#python',
    '#java',
    '#react',
    '#node',
    '#android',
    '#ios',
    '#startup',
    '#innovation',
    '#technology',
    '#digital',
    '#ai',
    '#machinelearning',
    '#data',
    '#cloud',
    '#security',
    '#blockchain',
  ];

  static List<String> getSuggestions(String query) {
    if (query.isEmpty || !query.startsWith('#')) {
      return [];
    }

    final queryLower = query.toLowerCase();
    final matchingHashtags = _popularHashtags
        .where((tag) => tag.toLowerCase().startsWith(queryLower))
        .toList();

    if (matchingHashtags.length > 5) {
      return matchingHashtags.take(5).toList();
    }

    return matchingHashtags;
  }

  static String? getCurrentHashtagQuery(String text, int cursorPosition) {
    if (cursorPosition > text.length) return null;

    final beforeCursor = text.substring(0, cursorPosition);
    final lastHashIndex = beforeCursor.lastIndexOf('#');

    if (lastHashIndex == -1) return null;

    final afterHash = beforeCursor.substring(lastHashIndex);
    final spaceIndex = afterHash.indexOf(' ');
    final commaIndex = afterHash.indexOf(',');

    if (spaceIndex == -1 && commaIndex == -1) {
      return afterHash;
    }

    final endIndex = (spaceIndex != -1 && commaIndex != -1)
        ? (spaceIndex < commaIndex ? spaceIndex : commaIndex)
        : (spaceIndex != -1 ? spaceIndex : commaIndex);

    if (endIndex == -1) return afterHash;
    return afterHash.substring(0, endIndex);
  }
}

