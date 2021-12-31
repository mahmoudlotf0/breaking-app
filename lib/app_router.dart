import 'business_logic/cubit/characters_cubit_cubit.dart';
import 'data/models/characters.dart';
import 'data/repository/characters_repository.dart';
import 'data/web_serveices/characters_web_services.dart';
import 'package:flutter/material.dart';

import 'constans/strings.dart';
import 'presentation/screens/character_details_screen.dart';
import 'presentation/screens/characters_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  late CharactersRepository charactersRepository;
  late CharactersCubitCubit charactersCubit;
  AppRouter() {
    charactersRepository = CharactersRepository(CharactersWebServices());
    charactersCubit = CharactersCubitCubit(charactersRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => charactersCubit,
            child: const CharactersScreen(),
          ),
        );
      case characterDetailsScreen:
        final Character character = settings.arguments as Character;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => CharactersCubitCubit(charactersRepository),
            child: CharacterDetailsScreen(character: character),
          ),
        );
    }
  }
}
