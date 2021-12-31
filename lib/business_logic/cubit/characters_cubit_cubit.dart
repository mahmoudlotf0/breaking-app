import 'package:bloc/bloc.dart';
import '../../data/models/character_quote.dart';
import 'package:meta/meta.dart';

import '../../data/models/characters.dart';
import '../../data/repository/characters_repository.dart';

part 'characters_cubit_state.dart';

class CharactersCubitCubit extends Cubit<CharactersCubitState> {
  final CharactersRepository charactersRepository;
  List<Character> characters = [];

  CharactersCubitCubit(this.charactersRepository)
      : super(CharactersCubitInitial());

  List<Character> getAllCharacters() {
    charactersRepository.getAllCharacters().then((List<Character> characters) {
      // * bbt3t el list ll state 3shan ast5dmha fe UI
      emit(CharactersLoaded(characters));
      this.characters = characters;
    });
    return characters;
  }

  void getCharactersQuotes(String characterName) {
    charactersRepository.getAllCharactersQuotes(characterName).then((quotes) {
      // * bbt3t el list ll state 3shan ast5dmha fe UI
      emit(CharacterQuotesLoaded(quotes));
    });
  }
}
