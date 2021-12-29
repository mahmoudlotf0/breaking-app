import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:blocappapi/data/models/characters.dart';
import 'package:blocappapi/data/repository/characters_repository.dart';

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
}
