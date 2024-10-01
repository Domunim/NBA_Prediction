class GameResultModel {
  String opponentTeam;
  bool isHome;
  DateTime gameDateTime;
  int score;
  int opponentScore;


  GameResultModel({
    required this.opponentTeam,
    required this.isHome,
    required this.gameDateTime,
    required this.score,
    required this.opponentScore,
  });

}