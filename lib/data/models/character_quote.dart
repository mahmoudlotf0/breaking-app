class CharacterQuote {
  late String quote;

  CharacterQuote.fromJson(Map<String, dynamic> json) {
    quote = json['quote'];
  }
}
