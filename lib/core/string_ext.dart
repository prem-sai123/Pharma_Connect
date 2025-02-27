extension StringExentions on String? {
  String get valueOrEmpty => this ?? '';

  String get titleCaseWords {
    final words = valueOrEmpty.split(' ');

    final capitalizedWords =
        words.map((word) {
          if (word.isEmpty) return word;
          return word[0].toUpperCase() + word.substring(1).toLowerCase();
        }).toList();
    return capitalizedWords.join(' ');
  }
}
