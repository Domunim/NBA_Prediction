import 'dart:ffi';

class MatchModel {
  DateTime date;
  String homeTeamName;
  String awayTeamName;
  Int oddsForHomeTeam;
  Int oodsForAwayTeam;


  MatchModel({
    required this.date,
    required this.homeTeamName,
    required this.awayTeamName,
    required this.oddsForHomeTeam,
    required this.oodsForAwayTeam,
  });

  static List<MatchModel> getMatches() {
      List<MatchModel> matches = [];

      // method to get list of matches from the API

      return matches;
  }

}