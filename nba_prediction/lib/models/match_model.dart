class MatchModel {
  DateTime date;
  String homeTeamShortName;
  String awayTeamShortName;
  int oddsForHomeTeam;
  int oddsForAwayTeam;


  MatchModel({
    required this.date,
    required this.homeTeamShortName,
    required this.awayTeamShortName,
    required this.oddsForHomeTeam,
    required this.oddsForAwayTeam,
  });

  static List<MatchModel> getMatches() {
      List<MatchModel> matches = [];

      // method to get list of matches from the API

      matches.add(
        MatchModel(
          date: DateTime.now(),
          homeTeamShortName: "MEM",
          awayTeamShortName: "MIN",
          oddsForHomeTeam: 85,
          oddsForAwayTeam: 15,
        )
      );

      matches.add(
        MatchModel(
          date: DateTime.parse("2024-08-27 21:30:00"),
          homeTeamShortName: "BKN",
          awayTeamShortName: "GSW",
          oddsForHomeTeam: 51,
          oddsForAwayTeam: 49,
        )
      );

      matches.add(
        MatchModel(
          date: DateTime.parse("2024-08-27 22:00:00"),
          homeTeamShortName: "CHI",
          awayTeamShortName: "LAL",
          oddsForHomeTeam: 44,
          oddsForAwayTeam: 56,
        )
      );

      matches.add(
        MatchModel(
          date: DateTime.parse("2024-08-27 23:00:00"),
          homeTeamShortName: "DEN",
          awayTeamShortName: "DAL",
          oddsForHomeTeam: 45,
          oddsForAwayTeam: 55,
        )
      );

      matches.add(
        MatchModel(
          date: DateTime.parse("2024-08-27 23:30:00"),
          homeTeamShortName: "LAC",
          awayTeamShortName: "WAS",
          oddsForHomeTeam: 39,
          oddsForAwayTeam: 61,
        )
      );

      return matches;
  }

}