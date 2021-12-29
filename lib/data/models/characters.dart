class Character {
  late int charId;
  late String name;
  late String nickName;
  late String image;
  late String birthday;
  late List jobs;
  late String statusIdDeadOrAlive;
  late List appearanceOfSeasons;
  late String actorName;
  late String categoryForTwoSeries;
  late List betterCallSaulApperance;
  Character.fromJson(Map<String, dynamic> json) {
    charId = json['char_id'];
    name = json['name'];
    nickName = json['nickname'];
    image = json['img'];
    birthday = json['birthday'];
    jobs = json['occupation'];
    statusIdDeadOrAlive = json['status'];
    appearanceOfSeasons = json['appearance'];
    actorName = json['portrayed'];
    categoryForTwoSeries = json['category'];
    betterCallSaulApperance = json['better_call_saul_appearance'];
  }
}
