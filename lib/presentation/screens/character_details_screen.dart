import 'package:blocappapi/constans/my_colors.dart';
import 'package:blocappapi/data/models/characters.dart';
import 'package:flutter/material.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final Character character;
  const CharacterDetailsScreen({Key? key, required this.character})
      : super(key: key);
  Widget buildSliverAppbar() {
    return SliverAppBar(
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

  Widget buildCharacterInfo({required String title, required String value}) {
    return RichText(
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

  @override
  Widget build(BuildContext context) {
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
                      // TODO: LAW EL ACTOR FE BETTER CALL ONLY DON'T SHOW SEASONS
                      buildCharacterInfo(
                        title: 'Job : ',
                        value: character.jobs.join(' / '),
                      ),
                      buildDivider(285),
                      buildCharacterInfo(
                        title: 'Appeared In : ',
                        value: character.categoryForTwoSeries,
                      ),
                      buildDivider(220),
                      buildCharacterInfo(
                        title: 'Seasons : ',
                        value: character.appearanceOfSeasons.join(' / '),
                      ),
                      buildDivider(240),
                      buildCharacterInfo(
                        title: 'Status : ',
                        value: character.statusIdDeadOrAlive,
                      ),
                      buildDivider(260),
                      character.betterCallSaulApperance.isEmpty
                          ? Container()
                          : buildCharacterInfo(
                              title: 'Better Call Soul Seasons : ',
                              value:
                                  character.betterCallSaulApperance.join(' / '),
                            ),
                      character.betterCallSaulApperance.isEmpty
                          ? Container()
                          : buildDivider(108),
                      buildCharacterInfo(
                        title: 'Actor/Actress : ',
                        value: character.actorName,
                      ),
                      buildDivider(200),
                    ],
                  ),
                ),
                const SizedBox(height: 500),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
