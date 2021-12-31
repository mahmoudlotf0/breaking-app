import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:blocappapi/business_logic/cubit/characters_cubit_cubit.dart';
import 'package:flutter/material.dart';

import 'package:blocappapi/constans/my_colors.dart';
import 'package:blocappapi/data/models/characters.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final Character character;
  const CharacterDetailsScreen({Key? key, required this.character})
      : super(key: key);
  Widget buildSliverAppbar() {
    return SliverAppBar(
      elevation: 0,
      expandedHeight: 600.0,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          character.nickName,
          style: const TextStyle(color: MyColors.myWhite),
        ),
        background: Hero(
          tag: character.charId,
          child: Image.network(character.image, fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget buildCharacterInfo({
    required String title,
    required String value,
    required double endIndent,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
            children: [
              TextSpan(
                text: title,
                style: const TextStyle(
                  color: MyColors.myWhite,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              TextSpan(
                text: value,
                style: const TextStyle(
                  color: MyColors.myWhite,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        buildDivider(endIndent),
      ],
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      color: MyColors.myYellow,
      height: 30.0,
      endIndent: endIndent,
      thickness: 2,
    );
  }

  Widget checkIfQuotesAreLoaded(CharactersCubitState state) {
    if (state is CharacterQuotesLoaded) {
      return displayRandomQuotesOrEmptySpace(state);
    }
    return showLoadingIndicator();
  }

  Widget displayRandomQuotesOrEmptySpace(state) {
    var quotes = state.quotes;
    if (quotes.isNotEmpty) {
      int randomQuoteIndex = Random().nextInt(quotes.length - 1);
      return Center(
        child: DefaultTextStyle(
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
            color: MyColors.myWhite,
            shadows: [
              Shadow(
                blurRadius: 7,
                color: MyColors.myYellow,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              FlickerAnimatedText(quotes[randomQuoteIndex].quote),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget showLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(color: MyColors.myYellow),
    );
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CharactersCubitCubit>(context)
        .getCharactersQuotes(character.name);
    final sizeWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppbar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildCharacterInfo(
                        title: 'Job : ',
                        value: character.jobs.join(' / '),
                        endIndent: sizeWidth * 0.78,
                      ),
                      buildCharacterInfo(
                        title: 'Appeared In : ',
                        value: character.categoryForTwoSeries,
                        endIndent: sizeWidth * 0.60,
                      ),
                      character.appearanceOfSeasons.isEmpty
                          ? Container()
                          : buildCharacterInfo(
                              title: 'Seasons : ',
                              value: character.appearanceOfSeasons.join(' / '),
                              endIndent: sizeWidth * 0.67,
                            ),
                      buildCharacterInfo(
                        title: 'Status : ',
                        value: character.statusIdDeadOrAlive,
                        endIndent: sizeWidth * 0.72,
                      ),
                      character.betterCallSaulApperance.isEmpty
                          ? Container()
                          : buildCharacterInfo(
                              title: 'Better Call Soul Seasons : ',
                              value:
                                  character.betterCallSaulApperance.join(' / '),
                              endIndent: sizeWidth * 0.30,
                            ),
                      buildCharacterInfo(
                        title: 'Actor/Actress : ',
                        value: character.actorName,
                        endIndent: sizeWidth * 0.55,
                      ),
                      const SizedBox(height: 20),
                      BlocBuilder<CharactersCubitCubit, CharactersCubitState>(
                        builder:
                            (BuildContext context, CharactersCubitState state) {
                          return checkIfQuotesAreLoaded(state);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 400),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
