import 'dart:convert';
import 'package:http/http.dart' as http;

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

  factory MatchModel.fromJson(Map<String, dynamic> json) {
    return MatchModel(
      date: DateTime.parse(json['date']),
      homeTeamShortName: json['homeTeamShortName'],
      awayTeamShortName: json['awayTeamShortName'],
      oddsForHomeTeam: json['oddsForHomeTeam'],
      oddsForAwayTeam: json['oddsForAwayTeam'],
    );
  }

  static Future<List<MatchModel>> fetchMatches() async {
    final response = await http.get(Uri.parse('(...)/matches')); // TODO change API URL after publishing

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => MatchModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load matches');
    }
  }
/*
// MOCK DATA
  static List<MatchModel> getMatches() {
      List<MatchModel> matches = [];

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
*/

}