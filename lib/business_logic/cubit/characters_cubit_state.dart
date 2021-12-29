part of 'characters_cubit_cubit.dart';

@immutable
abstract class CharactersCubitState {}

class CharactersCubitInitial extends CharactersCubitState {}

class CharactersLoaded extends CharactersCubitState {
  final List<Character> characters;

  CharactersLoaded(this.characters);
}

class CharacterQuotesLoaded extends CharactersCubitState {
  final List<CharacterQuote> quotes;

  CharacterQuotesLoaded(this.quotes);
}
