import 'package:blocappapi/data/models/characters.dart';
import 'package:blocappapi/data/web_serveices/characters_web_services.dart';

class CharactersRepository {
  final CharactersWebServices charactersWebServices;

  CharactersRepository(this.charactersWebServices);
  Future<List<Character>> getAllCharacters() async {
    final List characters = await charactersWebServices.getAllCharacters();
    return characters.map((e) => Character.fromJson(e)).toList();
  }
}
