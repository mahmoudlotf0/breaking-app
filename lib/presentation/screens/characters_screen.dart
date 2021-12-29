import 'package:blocappapi/business_logic/cubit/characters_cubit_cubit.dart';
import 'package:blocappapi/constans/my_colors.dart';
import 'package:blocappapi/data/models/characters.dart';
import 'package:blocappapi/presentation/widgets/character_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<Character> allCharacters;
  late List<Character> searchedForCharacters;
  bool isSearching = false;
  TextEditingController searchTextController = TextEditingController();
  Widget buildSearchField() {
    return TextField(
      controller: searchTextController,
      cursorColor: MyColors.myGrey,
      style: const TextStyle(
        color: MyColors.myGrey,
        fontSize: 18,
      ),
      decoration: const InputDecoration(
        hintText: 'Find a character',
        border: InputBorder.none,
        hintStyle: TextStyle(
          color: MyColors.myGrey,
          fontSize: 18,
        ),
      ),
      onChanged: (String searchedCharacterText) {
        addSearchForItemsToSearchedList(searchedCharacterText);
      },
    );
  }

  void addSearchForItemsToSearchedList(String searchedCharacter) {
    searchedForCharacters = allCharacters
        .where((Character character) =>
            character.name.toLowerCase().startsWith(searchedCharacter))
        .toList();
    setState(() {});
  }

  List<Widget> buildAppBarActions() {
    if (isSearching) {
      return [
        IconButton(
          onPressed: () {
            clearSearch();
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.clear,
            color: MyColors.myGrey,
          ),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: startSearch,
          icon: const Icon(
            Icons.search,
            color: MyColors.myGrey,
          ),
        ),
      ];
    }
  }

  void startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: stopSearch));
    setState(() {
      isSearching = true;
    });
  }

  void stopSearch() {
    clearSearch();
    setState(() {
      isSearching = false;
    });
  }

  void clearSearch() {
    setState(() {
      searchTextController.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    // * start bloc
    BlocProvider.of<CharactersCubitCubit>(context).getAllCharacters();
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharactersCubitCubit, CharactersCubitState>(
        builder: (BuildContext context, CharactersCubitState state) {
      if (state is CharactersLoaded) {
        allCharacters = state.characters;
        return buildLoadedListWidget();
      } else {
        return showLoadingIndicator();
      }
    });
  }

  Widget showLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(color: MyColors.myYellow),
    );
  }

  Widget buildLoadedListWidget() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.myGrey,
        child: Column(
          children: [
            buildCharactersList(),
          ],
        ),
      ),
    );
  }

  Widget buildCharactersList() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      shrinkWrap: true,
      itemCount: searchTextController.text.isEmpty
          ? allCharacters.length
          : searchedForCharacters.length,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemBuilder: (BuildContext context, int index) {
        return CharacterItem(
          character: searchTextController.text.isEmpty
              ? allCharacters[index]
              : searchedForCharacters[index],
        );
      },
    );
  }

  Widget buildAppBarTitle() {
    return const Text(
      'Characters',
      style: TextStyle(color: MyColors.myGrey),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: isSearching
            ? const BackButton(
                color: MyColors.myGrey,
              )
            : Container(),
        backgroundColor: MyColors.myYellow,
        title: isSearching ? buildSearchField() : buildAppBarTitle(),
        actions: buildAppBarActions(),
      ),
      body: buildBlocWidget(),
    );
  }
}
